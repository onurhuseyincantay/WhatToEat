//
//  RegisterPresenter.swift
//  WhatToEat
//
//  Created by Onur Hüseyin Çantay on 17.08.2018.
//  Copyright © 2018 Onur Hüseyin Çantay. All rights reserved.
//

import UIKit

class LoginPresenter: NSObject {
    var LoginDelegate : LoginDelegate
    let  modelColor = Colors()
    
    init(delegate: LoginDelegate) {
        self.LoginDelegate = delegate
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
    func login(email:String,password: String,completion : @escaping (Bool?)->()){
        var error : Bool?
        if email.isEmpty{
            self.LoginDelegate.DidFailed(message: "email can't be blank")
            error = true
        }else if password.isEmpty{
            self.LoginDelegate.DidFailed(message: "password can't be blank")
            error = true
        }
        // burası Firebase istek kısmı
        completion(error)
    }
   
}

protocol LoginDelegate {
    func showProgress()
    func hideProgress()
    func DidSucceed()
    func DidFailed(message: String)
    func navigateMainViewController()
    func navigateRegisterViewController()
}

