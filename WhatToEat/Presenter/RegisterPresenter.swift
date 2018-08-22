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
            self.registirationDelegate.DidFailed(message: "email can't be blank")
            error = true
        }else if password.isEmpty{
            self.registirationDelegate.DidFailed(message: "password can't be blank")
            error = true
        }else if name.isEmpty{
            self.registirationDelegate.DidFailed(message: "name can't be blank")
            error = true
        }else if surname.isEmpty{
            self.registirationDelegate.DidFailed(message: "surname can't be blank")
            error = true
        }
        completion(error)
    }
    func login(email:String,password: String,completion : @escaping (Bool?)->()){
        var error : Bool?
        if email.isEmpty{
            self.registirationDelegate.DidFailed(message: "email can't be blank")
            error = true
        }else if password.isEmpty{
            self.registirationDelegate.DidFailed(message: "password can't be blank")
            error = true
        }
        // burası Firebase istek kısmı
        completion(error)
    }
   
}

protocol RegistrationDelegate {
    func showProgress()
    func hideProgress()
    func DidSucceed()
    func DidFailed(message: String)
    func navigateMainView()
}

