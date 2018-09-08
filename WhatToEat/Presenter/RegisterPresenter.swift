//
//  RegisterPresenter.swift
//  WhatToEat
//
//  Created by Onur Hüseyin Çantay on 31.08.2018.
//  Copyright © 2018 Onur Hüseyin Çantay. All rights reserved.
//

import UIKit

class RegisterPresenter: NSObject {
    var registerationDelegate:RegisterDelegate!
    let  modelColor = Colors()
    
    private var colors : [UIColor] {
        return modelColor.colors
    }

    init(delegate:RegisterDelegate) {
        self.registerationDelegate=delegate
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
            self.registerationDelegate.DidFailed(message: "email can't be blank")
            error = true
            completion(error)
        }else if password.isEmpty{
            self.registerationDelegate.DidFailed(message: "password can't be blank")
            error = true
            completion(error)
        }else if name.isEmpty{
            self.registerationDelegate.DidFailed(message: "name can't be blank")
            error = true
            completion(error)
        }else if surname.isEmpty{
            self.registerationDelegate.DidFailed(message: "surname can't be blank")
            error = true
            completion(error)
        }
        Service.service.registerUser(email: email, name: name, surname: surname, password: password) { (result, user) in
            if result != nil {
                print("Not Available")
                return
            }
            print(user?.name)
            print(user?.surname)
            print("hello")
            completion(result)
        }
    }
}

protocol RegisterDelegate {
    func showProgress()
    func hideProgress()
    func DidSucceed()
    func DidFailed(message: String)
    func navigateMainViewController()
    func navigateLoginViewController()
}
