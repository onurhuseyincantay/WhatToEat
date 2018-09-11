//
//  MainViewController.swift
//  WhatToEat
//
//  Created by Onur Hüseyin Çantay on 19.08.2018.
//  Copyright © 2018 Onur Hüseyin Çantay. All rights reserved.
//

import UIKit

class MainViewController: UINavigationController {
    let user = User.getUser()
    override func viewDidLoad() {
        super.viewDidLoad()
        print(user!.id)
    }
    
}
