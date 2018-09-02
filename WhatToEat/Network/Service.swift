//
//  Service.swift
//  WhatToEat
//
//  Created by Onur Hüseyin Çantay on 31.08.2018.
//  Copyright © 2018 Onur Hüseyin Çantay. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseAuth

fileprivate let DB_BASE = Database.database().reference()
fileprivate let FIR_AUTH = Auth.auth()

public class Service{
    static let service = Service()
    private var _REF_USERS = DB_BASE.child("Users")
    private var _REF_SURVEYS = DB_BASE.child("Surveys")
    private var _REF_OFFERS = DB_BASE.child("Offers")
    
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    var REF_SURVEYS : DatabaseReference{
        return _REF_SURVEYS
    }
    
    var REF_OFFERS : DatabaseReference{
        return _REF_OFFERS
    }
    
    func createFirebaseUser(uid: String, userData: Dictionary<String,AnyObject>){
        _REF_USERS.child(uid).updateChildValues(userData)
    }
    
    private func getUser(userId uid:String,completion : @escaping (_ result: Bool, _ user: User?) -> ()){
        var user : User!
        _REF_USERS.child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            if let dict = snapshot.value as? Dictionary<String,AnyObject>{
                let id = snapshot.key
                let name = dict[keys.ID.rawValue] as! String
                let surname = dict[keys.SURNAME.rawValue] as! String
                let email = dict[keys.EMAIL.rawValue] as! String
                let joinedDate = dict[keys.JOINED_DATE.rawValue] as! Date
                let password = dict[keys.PASSWORD.rawValue] as! String
                let profileImageUrl = dict[keys.PROFILE_IMAGE_URL.rawValue] as! String
                user = User(id:id,name: name, surname: surname, email: email, password: password, joinedDate: joinedDate, surveys: [nil], offers: [nil], profileImage: profileImageUrl, finishedSurveys: [nil], acceptedOffers: [nil])
                completion(true,user!)
                
            }
        }) { (error) in
            completion(false,nil)
        }
    }
        
    
    
    func checkUserOnDatabase(email:String,password:String,completion : @escaping (_ result:Bool,_ user:User?)->()){
        FIR_AUTH.signIn(withEmail: email, password: password) { (user, error) in
            if error != nil{
                completion(false,nil)
            }
            if let logedInUser = user{
                self.getUser(userId: logedInUser.uid, completion: { (result, user) in
                    if result {
                        completion(true,user!)
                    }else{
                        completion(false,nil)
                    }
                })
            }
        }
    }
    
    
    func createSurvey(userId uid:String,surveyData:Dictionary<String,AnyObject>){
        self._REF_SURVEYS.child(uid).childByAutoId().updateChildValues(surveyData)
    }
    
    func createOffer(surveyId uid: String,offerData:Dictionary<String,AnyObject>)  {
        self._REF_OFFERS.child(uid).updateChildValues(offerData)
    }
    
    func joinOffer(surveyId sUID:String,offerId oUID : String,userData:Dictionary<String,AnyObject>){
        self._REF_OFFERS.child(sUID).child(oUID).updateChildValues(userData)
    }
    
}

enum keys :String{
    case NAME = "name"
    case SURNAME = "surname"
    case PASSWORD = "password"
    case EMAIL = "email"
    case ID = "id"
    case JOINED_DATE = "joinedDate"
    case OFFERS = "offers"
    case SURVEYS = "surveys"
    case PROFILE_IMAGE_URL = "profileImageUrl"
    case FINISHED_SURVEYS = "finishedSurveys"
    case ACCEPTED_OFFERS = "acceptedOffers"
}
