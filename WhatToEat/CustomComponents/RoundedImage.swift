//
//  RoundedImage.swift
//  WhatToEat
//
//  Created by Onur Hüseyin Çantay on 31.08.2018.
//  Copyright © 2018 Onur Hüseyin Çantay. All rights reserved.
//

import UIKit

class RoundedImage: UIImageView {
    override func layoutSubviews() {
        self.layer.cornerRadius = self.frame.width/2
        self.clipsToBounds = true
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor
    }
   

}
