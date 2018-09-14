//
//  UserModel.swift
//  WhatToEat
//
//  Created by Onur Hüseyin Çantay on 19.08.2018.
//  Copyright © 2018 Onur Hüseyin Çantay. All rights reserved.
//

import Foundation
class User : NSObject,NSCoding{
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("currentUser")
    private var _name : String!
    private var _id : String!
    private var _surname : String!
    private var _email : String!
    private var _password : String!
    private var _joinedDate : Date!
    private var _surveys : [SurveyModel?]
    private var _offers : [OfferModel?]
    private var _profileImage : String?
    private var _finishedSurveys : [SurveyModel?]
    private var _acceptedOffers : [OfferModel?]
    
    var name : String{
        get{
            return self._name
        }set{
            self._name = newValue
        }
    }
    
    var id : String{
        get{
            return self._id
        }set{
            self._id = newValue
        }
    }
    
    var surname : String{
        get{
            return self._surname
        }set{
            self._surname = newValue
        }
    }
    
    var email : String{
        get{
            return self._email
        }set{
            self._email = newValue
        }
    }
    
    var password : String{
        get{
            return self._password
        }set{
            self._password = newValue
        }
    }
    
    var joinedDate : Date{
        get{
            return self._joinedDate
        }
    }
    
    var surveys : [SurveyModel?]{
        get{
            return self._surveys
        }set{
            self._surveys = newValue
        }
    }
    
    var offers : [OfferModel?]{
        get{
            return self._offers
        }set{
            self._offers = newValue
        }
    }
    
    var profileImage : String?{
        get{
            return self._profileImage
        }set{
            self._profileImage = newValue
        }
    }
    
    var finishedSurveys : [SurveyModel?]{
        get{
            return self._finishedSurveys
        }set{
            self._finishedSurveys = newValue
        }
    }
    
    var acceptedOffers :[OfferModel?]{
        get{
            return self._acceptedOffers
        }set{
            self._acceptedOffers = newValue
        }
    }
    
    init(id:String,name: String,surname:String,email:String,password : String,joinedDate : Date,surveys : [SurveyModel?],offers :[OfferModel?],profileImage : String,finishedSurveys : [SurveyModel?],acceptedOffers : [OfferModel?]) {
        self._name = name
        self._id = id
        self._surname = surname
        self._email = email
        self._profileImage = profileImage
        self._password = password
        self._joinedDate = joinedDate
        self._surveys = surveys
        self._offers = offers
        self._finishedSurveys = finishedSurveys
        self._acceptedOffers = acceptedOffers
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObject(forKey: "id") as! String
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let surname = aDecoder.decodeObject(forKey: "surname") as! String
        let email = aDecoder.decodeObject(forKey: "email") as! String
        let profileImage = aDecoder.decodeObject(forKey: "profileImage") as! String
        let password = aDecoder.decodeObject(forKey: "password") as! String
        let joinedDate = aDecoder.decodeObject(forKey: "joinedDate") as! Date
        let surveys = aDecoder.decodeObject(forKey: "surveys") as! [SurveyModel?]
        let offers = aDecoder.decodeObject(forKey: "offers") as! [OfferModel?]
        let finishedSurveys = aDecoder.decodeObject(forKey: "finishedSurveys") as! [SurveyModel?]
        let acceptedOffers = aDecoder.decodeObject(forKey: "acceptedOffers") as! [OfferModel?]
        self.init(id: id, name: name, surname: surname, email: email, password: password, joinedDate: joinedDate, surveys: surveys, offers: offers, profileImage: profileImage, finishedSurveys: finishedSurveys, acceptedOffers: acceptedOffers)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(surname, forKey: "surname")
        aCoder.encode(email,forKey:"email")
        aCoder.encode(profileImage, forKey: "profileImage")
        aCoder.encode(password, forKey: "password")
        aCoder.encode(joinedDate, forKey: "joinedDate")
        aCoder.encode(surveys,forKey:"surveys")
        aCoder.encode(offers,forKey:"offers")
        aCoder.encode(finishedSurveys,forKey:"finishedSurveys")
        aCoder.encode(acceptedOffers,forKey:"acceptedOffers")
        
    }
    
    class func saveUser(user:User){
        let savedData = NSKeyedArchiver.archivedData(withRootObject: user)
        do {
            try savedData.write(to: ArchiveURL)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    class func getUser()->User?{
        return NSKeyedUnarchiver.unarchiveObject(withFile: ArchiveURL.path) as? User
    }
    
}
