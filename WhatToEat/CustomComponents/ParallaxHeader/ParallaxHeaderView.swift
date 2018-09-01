//
//  ParallaxHeaderView.swift
//  WhatToEat
//
//  Created by Bertuğ Yılmaz on 1.09.2018.
//  Copyright © 2018 Onur Hüseyin Çantay. All rights reserved.
//

import UIKit

class ParallaxHeaderView: UICollectionReusableView {

    @IBOutlet weak var imageView: UIImageView?
    
    @IBOutlet weak var imageViewConstraint: NSLayoutConstraint!
    private var headerHeight: CGFloat!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        headerHeight = self.imageView?.bounds.height
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        let attributes = layoutAttributes
        self.imageViewConstraint.constant = headerHeight
    }
}
