//
//  UserModel.swift
//  WhatToEat
//
//  Created by Onur Hüseyin Çantay on 19.08.2018.
//  Copyright © 2018 Onur Hüseyin Çantay. All rights reserved.
//

import Foundation
class User : Codable {
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
    
}
