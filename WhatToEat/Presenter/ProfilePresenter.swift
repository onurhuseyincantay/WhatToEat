//
//  ProfilePresenter.swift
//  WhatToEat
//
//  Created by Bertuğ Yılmaz on 1.09.2018.
//  Copyright © 2018 Onur Hüseyin Çantay. All rights reserved.
//

import UIKit

class ProfilePresenter: NSObject {
    
    var delegate: ProfileDelegate
    
    init(delegate: ProfileDelegate) {
        self.delegate = delegate
    }
}

extension ProfilePresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let reusableCell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "parallaxCell", for: indexPath) as? ParallaxCollectionReusableView {
            return reusableCell
        }
        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath) as? ProfileCell {
            cell.nameLabel.text = String(indexPath.row)
            return cell
        }
        return UICollectionViewCell()
    }
}

protocol ProfileDelegate {
}
