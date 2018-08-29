//
//  ProfileViewController.swift
//  WhatToEat
//
//  Created by Onur Hüseyin Çantay on 29.08.2018.
//  Copyright © 2018 Onur Hüseyin Çantay. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak private var scrollView : UIScrollView!
    @IBOutlet weak private var purpleView : UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentInset = UIEdgeInsets(top: 250, left: 0, bottom: 0, right: 0)
        purpleView.contentMode = .scaleToFill
        purpleView.clipsToBounds = true
        // Do any additional setup after loading the view.
    }

}
extension ProfileViewController:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = 250 - (scrollView.contentOffset.y + 250)
        let height = min(max(y,60),400)
        purpleView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
    }
}

