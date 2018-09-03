//
//  ProfileViewController.swift
//  WhatToEat
//
//  Created by Onur Hüseyin Çantay on 29.08.2018.
//  Copyright © 2018 Onur Hüseyin Çantay. All rights reserved.
//

import UIKit

class ProfileViewController: UICollectionViewController {
    
    private var profilePresenter: ProfilePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profilePresenter = ProfilePresenter(delegate: self)
        self.setupCollectionView()
    }
    
    func setupCollectionView(){
        self.collectionView?.register(UINib(nibName: "ParallaxCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "parallaxCell")
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self.profilePresenter
        
        guard let width = collectionView?.bounds.width else { return }
        let layout = collectionViewLayout as! ParallaxHeaderFlowLayout
        layout.headerReferenceSize = CGSize(width: width, height: 300)
        layout.itemSize = CGSize(width: width / 2, height: 60)
    }
}

extension ProfileViewController: ProfileDelegate {
    
}
