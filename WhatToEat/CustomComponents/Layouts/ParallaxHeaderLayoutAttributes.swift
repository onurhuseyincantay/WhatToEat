//
//  ParallaxHeaderLayoutAttributes.swift
//  WhatToEat
//
//  Created by Bertuğ Yılmaz on 1.09.2018.
//  Copyright © 2018 Onur Hüseyin Çantay. All rights reserved.
//

import UIKit

class ParallaxHeaderLayoutAttributes: UICollectionViewLayoutAttributes {
    
    var deltaY: CGFloat = 0
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as! ParallaxHeaderLayoutAttributes
        copy.deltaY = deltaY
        return copy
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let attributes = object as? ParallaxHeaderLayoutAttributes {
            if attributes.deltaY == deltaY {
                return super.isEqual(object)
            }
        }
        return false
    }
}
