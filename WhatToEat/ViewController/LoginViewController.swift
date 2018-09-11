//
//  ViewController.swift
//  WhatToEat
//
//  Created by Onur Hüseyin Çantay on 17.08.2018.
//  Copyright © 2018 Onur Hüseyin Çantay. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet private weak var emailTextField : UITextField!
    @IBOutlet private weak var passwordTextField : UITextField!
    @IBOutlet weak private var logoImageView : UIImageView!
    @IBOutlet weak var logoConstraint: NSLayoutConstraint!
    
    private var presenter : LoginPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = LoginPresenter(delegate: self)
        presenter.modelColor.updateColors {
            self.view.backgroundColor = self.presenter.modelColor.colors.first!
        }
        self.logoConstraint.constant = self.logoImageView.frame.height / 8
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.emailTextField.text = nil
        self.passwordTextField.text = nil
        presenter.modelColor.updateColors {
            self.view.backgroundColor = self.presenter.modelColor.colors.first!
        }
    }
    
    

    
    @IBAction func loginPressed(_ sender: UIButton){
        self.presenter.login(email: emailTextField.text!, password: passwordTextField.text!) { (result,user)  in
            if result == true {
                self.DidSucceed(user: user!)
                User.saveUser(user!)
                self.navigateMainViewController(user: user!)
                
            }else{
                self.DidFailed(message: "Fields Cannot Be Blank")
            }
        }
    }
    @IBAction func registerPressed(_ sender : UIButton){
        self.navigateRegisterViewController()
    }
}

extension LoginViewController:LoginDelegate{
    func navigateMainViewController(user:User) {
        if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController{
            print("S.a")
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
    func navigateRegisterViewController() {
        if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController{
            print("S.a")
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
    func showProgress() {
        print("Showing Progress")
    }
    
    func hideProgress() {
        print("Hiding Progress")
    }
    
    func DidSucceed(user : User) {
        print("Welcome \(user.name)")
    }
    
    func DidFailed(message: String) {
        print(message)
    }
    
}

