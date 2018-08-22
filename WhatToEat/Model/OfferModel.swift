//
//  OfferModel.swift
//  WhatToEat
//
//  Created by Onur Hüseyin Çantay on 22.08.2018.
//  Copyright © 2018 Onur Hüseyin Çantay. All rights reserved.
//

import Foundation

class OfferModel:Codable {
    private var _openedUser : User
    private var _joinedUsers : [User?]
    private var _offerDate : Date
    private var _offeredMeal : String
    private var _offerCount : Int
    var joinedUsers:[User?]{
        get{
            return _joinedUsers
        }set{
            self._joinedUsers = newValue
        }
    }
    var openedUser : User{
        get{
            return _openedUser
        }set{
            self._openedUser = newValue
        }
    }
    var offerDate : Date{
        get{
            return _offerDate
        }set{
            self.offerDate = newValue
        }
    }
    var offeredMeal : String{
        get{
            return _offeredMeal
        }set{
            self._offeredMeal = newValue
        }
    }
    var offerCount : Int{
        get{
            return self._joinedUsers.count + 1
        }set{
            self._offerCount = self._joinedUsers.count + 1
        }
    }
    init(joinedUsers : [User?],openedUser : User,offeredMeal:String) {
        self._joinedUsers = joinedUsers
        self._openedUser = openedUser
        self._offerDate = Date()
        self._offeredMeal = offeredMeal
        self._offerCount = joinedUsers.count + 1
        
    }
}
