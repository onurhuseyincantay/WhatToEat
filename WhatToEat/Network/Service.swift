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
    private var _REF_USERS = DB_BASE.child(keys.USERS.rawValue)
    private var _REF_SURVEYS = DB_BASE.child(keys.SURVEYS.rawValue)
    private var _REF_OFFERS = DB_BASE.child(keys.OFFERS.rawValue)
    
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    var REF_SURVEYS : DatabaseReference{
        return _REF_SURVEYS
    }
    
    var REF_OFFERS : DatabaseReference{
        return _REF_OFFERS
    }
    /// this function gets user data from database
    private func getUser(userId uid:String,completion : @escaping (_ result: Bool, _ user: User?) -> ()){
        _REF_USERS.child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            if let dict = snapshot.value as? Dictionary<String,AnyObject>{
                let id = snapshot.key
                let name = dict[keys.ID.rawValue] as! String
                let surname = dict[keys.SURNAME.rawValue] as! String
                let email = dict[keys.EMAIL.rawValue] as! String
                let dateString = dict[keys.JOINED_DATE.rawValue] as! String
                let joinedDate = dateString.toDate(format: keys.DATE_FORMAT.rawValue)
                let password = dict[keys.PASSWORD.rawValue] as! String
                let profileImageUrl = dict[keys.PROFILE_IMAGE_URL.rawValue] as! String
                let userObject = User(id:id,name: name, surname: surname, email: email, password: password, joinedDate: joinedDate!, surveys: [nil], offers: [nil], profileImage: profileImageUrl, finishedSurveys: [nil], acceptedOffers: [nil])
                completion(true,userObject)
            }
        }) { (error) in
            print(error.localizedDescription)
            completion(false,nil)
        }
    }
    
    func getSurveys(completion : @escaping (_ status: Bool,_ surveys:[SurveyModel?]) -> ()) {
        self._REF_SURVEYS.observe(.value, with: { (snapshots) in
            if let snapshot = snapshots.children.allObjects as? [DataSnapshot]{
            var surveys : [SurveyModel?] = []
                for snap in snapshot{
                    print("Onur : \(snap)")
                    print("-----------------")
                    
                    print("Onur : snap Value\(snap.value)")
                    self.getUser(userId: snap.key, completion: { (status, user) in
                        print("geting Users")
                        if status == false {
                            print("user not found")
                            completion(false,[nil])
                        }
                        if let surveySnap = snap.children.allObjects as? [DataSnapshot]{
                            for survey in surveySnap{
                                if let dict = survey.value as? Dictionary<String,AnyObject>{
                                    print("Hello Dict")
                                    print("Onur : Dict \(dict)")
                                    // burada joined users değişecek şimdilik kurgulayamadım
                                    surveys.append(SurveyModel(header: dict[keys.HEADER.rawValue] as! String, description: dict[keys.DESCRIPTION.rawValue] as! String, publishDate: (dict[keys.PUBLISH_DATE.rawValue] as! String).toDate(format: keys.DATE_FORMAT.rawValue)!, openedUser: user!, joinedUsers: [nil]))
                                    if snap == snapshot.last && survey == surveySnap.last{
                                        completion(true,surveys)
                                    }
                                }
                            }
                            
                        }
                    })
                }
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
    
    /// This Function checks for user exist or not
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
    
    func createOffer(surveyId sid: String,userId uid:String,offerData:Dictionary<String,AnyObject>)  {
        self._REF_OFFERS.child(sid).child(uid).updateChildValues(offerData)
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
    case DATE_FORMAT = "yyyy-MM-dd hh:mm:ss +SSSS"
    case ID = "id"
    case USER_ID = "userId"
    case DESCRIPTION = "description"
    case JOINED_DATE = "joinedDate"
    case PUBLISH_DATE = "publishDate"
    case JOINED_USERS = "joinedUsers"
    case OFFERS = "Offers"
    case SURVEYS = "Surveys"
    case USERS = "Users"
    case HEADER = "header"
    case PROFILE_IMAGE_URL = "profileImageUrl"
    case FINISHED_SURVEYS = "finishedSurveys"
    case ACCEPTED_OFFERS = "acceptedOffers"
}
