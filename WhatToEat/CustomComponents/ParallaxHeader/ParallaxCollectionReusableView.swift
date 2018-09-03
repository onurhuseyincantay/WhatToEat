//
//  ParallaxCollectionReusableView.swift
//  WhatToEat
//
//  Created by Bertuğ Yılmaz on 1.09.2018.
//  Copyright © 2018 Onur Hüseyin Çantay. All rights reserved.
//

import UIKit

class ParallaxCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var backgroundImageViewConstraint: NSLayoutConstraint!
    private var headerHeight: CGFloat = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        headerHeight = backgroundImageView.bounds.height
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
        let attributes = layoutAttributes as! ParallaxHeaderLayoutAttributes
        backgroundImageViewConstraint.constant = headerHeight - attributes.deltaY
    }
    
}
