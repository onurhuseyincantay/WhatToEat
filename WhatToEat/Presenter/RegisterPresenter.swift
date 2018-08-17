//
//  RegisterPresenter.swift
//  WhatToEat
//
//  Created by Onur Hüseyin Çantay on 17.08.2018.
//  Copyright © 2018 Onur Hüseyin Çantay. All rights reserved.
//

import UIKit

class RegisterPresenter: NSObject {
    var registirationDelegate : RegistrationDelegate
    let backgroundColor : UIColor = .white
    let  modelColor = Colors()
    init(delegate: RegistrationDelegate) {
        self.registirationDelegate = delegate
    }
    private var colors : [UIColor] {
        return modelColor.colors
    }
    func updateColors(completion : @escaping () -> () ) {
        self.modelColor.updateColors {
            print("Colors Shuffled")
            completion()
        }
    }
    func register(email: String, password: String, name: String, surname:String,completion : @escaping (Bool?)->()){
        var error : Bool?
        if email.isEmpty{
            self.registirationDelegate.registrationDidFailed(message: "email can't be blank")
            error = true
        }else if password.isEmpty{
            self.registirationDelegate.registrationDidFailed(message: "password can't be blank")
            error = true
        }else if name.isEmpty{
            self.registirationDelegate.registrationDidFailed(message: "name can't be blank")
            error = true
        }else if surname.isEmpty{
            self.registirationDelegate.registrationDidFailed(message: "surname can't be blank")
            error = true
        }
        completion(error)
    }
}

protocol RegistrationDelegate {
    func showProgress()
    func hideProgress()
    func registrationDidSucceed()
    func registrationDidFailed(message: String)
}
