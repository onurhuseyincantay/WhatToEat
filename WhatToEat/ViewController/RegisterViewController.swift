//
//  RegisterViewController.swift
//  WhatToEat
//
//  Created by Onur Hüseyin Çantay on 31.08.2018.
//  Copyright © 2018 Onur Hüseyin Çantay. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak private var emailTextField : UITextField!
    @IBOutlet weak private var passwordTextField : UITextField!
    @IBOutlet weak private var nameTextField : UITextField!
    @IBOutlet weak private var surnameTextField : UITextField!
    @IBOutlet weak private var profilePhotoImageView : UIImageView!
    @IBOutlet weak private var photoChooserRecognizer : UITapGestureRecognizer!
    @IBOutlet weak var profilePhotoConstraint: NSLayoutConstraint!
    
    var presenter : RegisterPresenter!
    private var photoUpdated : Bool!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = RegisterPresenter(delegate: self)
        self.presenter.modelColor.updateColors {
            self.view.backgroundColor = self.presenter.modelColor.colors.first!
        }
        self.profilePhotoConstraint.constant = -self.profilePhotoImageView.frame.height / 2
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    @IBAction func backPressed(_ sender : UIButton){
        self.navigateLoginViewController()
    }

}
extension RegisterViewController : RegisterDelegate{
    func navigateMainViewController() {
        if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController{
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
    
    func DidSucceed() {
        print("Succeed")
    }
    
    func DidFailed(message: String) {
        print(message)
    }
    
    func navigateLoginViewController() {
        self.dismiss(animated: true, completion: nil)
        print("Back To Login")
    }
    
    
}
