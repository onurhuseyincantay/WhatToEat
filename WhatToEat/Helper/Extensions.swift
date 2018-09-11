//
//  Extensions.swift
//  WhatToEat
//
//  Created by Onur Hüseyin Çantay on 8.09.2018.
//  Copyright © 2018 Onur Hüseyin Çantay. All rights reserved.
//

import UIKit

extension String {
    
    func toDate (format: String) -> Date? {
        return DateFormatter(format: format).date(from: self)
    }
    
    func toDateString (inputFormat: String, outputFormat:String) -> String? {
        if let date = toDate(format: inputFormat) {
            return DateFormatter(format: outputFormat).string(from: date)
        }
        return nil
    }
}

extension Date {
    func toString (format:String) -> String? {
        return DateFormatter(format: format).string(from: self)
    }
}

extension DateFormatter {
    convenience init (format: String) {
        self.init()
        dateFormat = format
        locale = Locale.current
    }
}

extension UIViewController{
    func getCurrentUser() -> User {
        let userDefaults = UserDefaults.standard
        let decoded  = userDefaults.object(forKey: "currentUser") as! Data
        let decodedUser = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! User
        return decodedUser
    }
    
    func saveUserToUserDefaultsAsData(user:User) {
        let userDefaults = UserDefaults.standard
        let encodedData : Data = NSKeyedArchiver.archivedData(withRootObject: user)
        userDefaults.set(encodedData, forKey: "currentUser")
        userDefaults.synchronize()
    }
}
