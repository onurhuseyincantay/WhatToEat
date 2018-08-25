//
//  SurveyOfferCellTableViewCell.swift
//  WhatToEat
//
//  Created by Onur Hüseyin Çantay on 25.08.2018.
//  Copyright © 2018 Onur Hüseyin Çantay. All rights reserved.
//

import UIKit

class SurveyOfferCell: UITableViewCell {
    @IBOutlet weak var profileImage : UIImageView!
    @IBOutlet weak var offerHeader : UILabel!
    @IBOutlet weak var offerDescription : UILabel!
    @IBOutlet weak var offerDate : UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var offer:OfferModel!{
        didSet{
            //  profileImage.image = UIImage(named: offer.openedUser.profileImage ?? "")
            self.offerHeader.text = offer.openedUser.name
            self.offerDescription.text = offer.offeredMeal
            self.profileImage.layer.cornerRadius = self.profileImage.frame.height / 2 + 10
            self.offerDate.text = offer.offerDate.description
        }
    }
  

}
