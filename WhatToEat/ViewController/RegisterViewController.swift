//
//  ViewController.swift
//  WhatToEat
//
//  Created by Onur Hüseyin Çantay on 17.08.2018.
//  Copyright © 2018 Onur Hüseyin Çantay. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet private weak var nameTextField : UITextField!
    @IBOutlet private weak var surnameTextField : UITextField!
    @IBOutlet private weak var emailTextField : UITextField!
    @IBOutlet private weak var passwordTextField : UITextField!
    
    private var presenter : RegisterPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = RegisterPresenter(delegate: self)
        presenter.modelColor.updateColors {
            self.view.backgroundColor = self.presenter.modelColor.colors.first!
        }
    }
    
    @IBAction func registerPressed(_ sender : UIButton){
        self.presenter.register(email: emailTextField.text!, password: passwordTextField.text!, name: nameTextField.text!, surname: surnameTextField.text!) { (error) in
            if error != nil{
                self.DidFailed(message: "Register Failed")
            }else{
                self.DidSucceed()
            }
        }
    }
    @IBAction func loginPressed(_ sender: UIButton){
        self.presenter.login(email: emailTextField.text!, password: passwordTextField.text!) { (error) in
            if error != nil {
                self.DidFailed(message: "Login Failed")
            }else{
                self.DidSucceed()
            }
        }
    }
}

extension RegisterViewController:RegistrationDelegate{
    func showProgress() {
        print("Showing Progress")
    }
    
    func hideProgress() {
        print("Hiding Progress")
    }
    
    func DidSucceed() {
        print("Succeed")
    }
    
    func DidFailed(message: String) {
        print(message)
    }
    func navigateMainView(user : User) {
        if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController{
            print("S.a")
            self.present(viewController, animated: true) {
                viewController.currentUser = user
            }
        }
    }
}

