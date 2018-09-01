//
//  ParallaxHeaderFlowLayout.swift
//  WhatToEat
//
//  Created by Bertuğ Yılmaz on 1.09.2018.
//  Copyright © 2018 Onur Hüseyin Çantay. All rights reserved.
//

import UIKit

class ParallaxHeaderFlowLayout: UICollectionViewFlowLayout {
    
    override class var layoutAttributesClass: AnyClass {
        return ParallaxHeaderLayoutAttributes.self
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect) as! [ParallaxHeaderLayoutAttributes]
        
        let offset = collectionView!.contentOffset
        if offset.y < 0 {
            let deltaY = fabs(offset.y)
            for atributes in layoutAttributes {
                if let elementKind = atributes.representedElementKind {
                    if elementKind == UICollectionElementKindSectionHeader {
                        var frame = atributes.frame
                        frame.size.height = max(0, headerReferenceSize.height + deltaY)
                        frame.origin.y = frame.minY - deltaY
                        atributes.frame = frame
                        atributes.deltaY = deltaY
                    }
                }
            }
        }
        return layoutAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

}
