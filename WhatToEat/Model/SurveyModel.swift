//
//  ReviewModel.swift
//  WhatToEat
//
//  Created by Onur Hüseyin Çantay on 22.08.2018.
//  Copyright © 2018 Onur Hüseyin Çantay. All rights reserved.
//

import Foundation

class SurveyModel :NSCoding{
    private var _header : String!
    private var _description : String!
    private var _publishDate : Date!
    private var _openedUser : User!
    private var _joinedUsers : [User?]
    private var _isAccepted : Bool!
    var header : String{
        get{
            return _header
        }set{
            self._header = newValue
        }
    }
    var description : String{
        get{
            return _description
        }set{
            self._description = newValue
        }
    }
    var publishDate : Date{
        get{
            return _publishDate
        }
    }
    var openedUser : User{
        get{
            return _openedUser
        }set{
            self._openedUser = newValue
        }
    }
    var joinedUsers:[User?]{
        get{
            return _joinedUsers
        }set{
            self._joinedUsers = newValue
        }
    }
    var isAccepted : Bool!{
        get{
            return _isAccepted
        }set{
            self._isAccepted =  newValue
        }
    }
    init(header : String,description : String,publishDate :Date,openedUser : User,joinedUsers:[User?],isAccepted : Bool = false) {
        self._header = header
        self._description = description
        self._publishDate = publishDate
        self._openedUser = openedUser
        self._joinedUsers = joinedUsers
        self._isAccepted = isAccepted
    }
    required convenience init(coder aDecoder: NSCoder) {
        let header = aDecoder.decodeObject(forKey: "header") as! String
        let description = aDecoder.decodeObject(forKey: "description") as! String
        let publishDate = aDecoder.decodeObject(forKey: "publishDate") as! Date
        let joinedUsers = aDecoder.decodeObject(forKey: "joinedUsers") as! [User?]
        let openedUser = aDecoder.decodeObject(forKey: "openedUser") as! User
        let isAccepted = aDecoder.decodeBool(forKey: "isAccepted")
        self.init(header: header, description: description, publishDate: publishDate, openedUser: openedUser, joinedUsers: joinedUsers, isAccepted: isAccepted)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(header, forKey: "header")
        aCoder.encode(description, forKey: "description")
        aCoder.encode(publishDate, forKey: "publishDate")
        aCoder.encode(joinedUsers,forKey:"joinedUsers")
        aCoder.encode(isAccepted, forKey: "isAccepted")
        aCoder.encode(openedUser,forKey:"openedUser")
    }
    
}
