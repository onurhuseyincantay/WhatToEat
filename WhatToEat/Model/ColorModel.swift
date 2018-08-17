//
//  ColorModel.swift
//  WhatToEat
//
//  Created by Onur Hüseyin Çantay on 17.08.2018.
//  Copyright © 2018 Onur Hüseyin Çantay. All rights reserved.
//


import UIKit
import GameplayKit
class Colors {
    typealias UpdateColorsCompl = () -> ()
    var colors : [UIColor] = []
    private let colorStage : [UIColor] = [.black,.green,.darkGray,.purple,.blue,.cyan]
    
    func updateColors(completion : @escaping UpdateColorsCompl){
        let random = GKRandomSource.sharedRandom()
        self.colors = random.arrayByShufflingObjects(in: colorStage) as! [UIColor]
        completion()
    }
}
