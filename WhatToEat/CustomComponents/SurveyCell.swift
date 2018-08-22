//
//  SurveyCell.swift
//  WhatToEat
//
//  Created by Onur Hüseyin Çantay on 22.08.2018.
//  Copyright © 2018 Onur Hüseyin Çantay. All rights reserved.
//

import UIKit

class SurveyCell: UITableViewCell {
    @IBOutlet weak var profileImage : UIImageView!
    @IBOutlet weak var surveyHeader : UILabel!
    @IBOutlet weak var surveyDescription : UILabel!
    @IBOutlet weak var surveyDate : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    var survey:SurveyModel!{
        didSet{
        //  profileImage.image = UIImage(named: survey.openedUser.profileImage ?? "")
            surveyHeader.text = survey.header
            self.profileImage.layer.cornerRadius = self.profileImage.frame.height / 2 + 10
            self.profileImage.clipsToBounds = true
            surveyDescription.text = survey.description
            surveyDate.text = survey.publishDate.description
        }
    }
    
    
    
}
