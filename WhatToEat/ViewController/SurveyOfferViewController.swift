//
//  SurveyOfferViewController.swift
//  WhatToEat
//
//  Created by Onur Hüseyin Çantay on 25.08.2018.
//  Copyright © 2018 Onur Hüseyin Çantay. All rights reserved.
//

import UIKit

class SurveyOfferViewController: UIViewController,UITableViewDelegate {
    @IBOutlet weak var tableView : UITableView!
    private var surveyOfferPresenter : SurveyOfferPresenter!
    var survey : SurveyModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.surveyOfferPresenter = SurveyOfferPresenter(with: self, for: survey)
        self.prepareTableView()
    }
    
    private func prepareTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self.surveyOfferPresenter
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension SurveyOfferViewController:SurveyOfferDelegate{
    func addOffer(user: User) {
        print("Offer Added:"+user.name)
    }
    
    func giveVoteForOffer(user: User) {
        print("Vote Gived:"+user.name)
    }
}

