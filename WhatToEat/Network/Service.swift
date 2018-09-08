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
    
  
    
    private func getUser(userId uid:String,completion : @escaping (_ result: Bool, _ user: User?) -> ()){
        _REF_USERS.child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            if let dict = snapshot.value as? Dictionary<String,AnyObject>{
                let id = snapshot.key
                let name = dict[keys.ID.rawValue] as! String
                let surname = dict[keys.SURNAME.rawValue] as! String
                let email = dict[keys.EMAIL.rawValue] as! String
                let dateString = dict[keys.JOINED_DATE.rawValue] as! String
                let joinedDate = dateString.toDate(format: "yyyy-MM-dd hh:mm:ss +SSSS")
                let password = dict[keys.PASSWORD.rawValue] as! String
                let profileImageUrl = dict[keys.PROFILE_IMAGE_URL.rawValue] as! String
                let userObject = User(id:id,name: name, surname: surname, email: email, password: password, joinedDate: joinedDate!, surveys: [nil], offers: [nil], profileImage: profileImageUrl, finishedSurveys: [nil], acceptedOffers: [nil])
                completion(true,userObject)
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
    
    func registerUser(email:String,name:String,surname:String,password:String,completion : @escaping (_ result:Bool,_ user:User?)->()) {
        FIR_AUTH.createUser(withEmail: email, password: password) { (user, error) in
            if error != nil{
                completion(false,nil)
            }
            guard let id = user?.uid else{
                completion(false,nil)
                print("no UID")
                return
            }
            let createdUser : Dictionary<String,AnyObject> = [keys.ID.rawValue:id as AnyObject,keys.NAME.rawValue:name as AnyObject,keys.SURNAME.rawValue:surname as AnyObject,keys.PROFILE_IMAGE_URL.rawValue:"" as AnyObject,keys.JOINED_DATE.rawValue:Date().description as AnyObject,keys.PASSWORD.rawValue:password as AnyObject,keys.EMAIL.rawValue:email as AnyObject]
            FIR_AUTH.signIn(withEmail: email , password: password) { (user, error) in
                if error != nil{
                    print("GG")
                }
                self._REF_USERS.child(id).updateChildValues(createdUser)
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
