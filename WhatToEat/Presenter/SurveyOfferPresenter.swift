//
//  SurveyOfferPresenter.swift
//  WhatToEat
//
//  Created by Onur Hüseyin Çantay on 25.08.2018.
//  Copyright © 2018 Onur Hüseyin Çantay. All rights reserved.
//

import UIKit

class SurveyOfferPresenter: NSObject {
    var surveyOfferDelegate : SurveyOfferDelegate
    let survey : SurveyModel!
    var offers : [OfferModel?] = []
    let user = User(name: "Onur", surname: "Çantay", email: "ohc3807@gmail.com", password: "123456", joinedDate:Date(), surveys: [nil], offers: [nil], profileImage: "www.bombabomba.com", finishedSurveys: [nil], acceptedOffers: [nil])
    
    let cellIdentifier = "SurveyOfferCell"
    init(with delegate:SurveyOfferDelegate,for survey:SurveyModel) {
        self.surveyOfferDelegate = delegate
        self.survey = survey
        self.offers = [OfferModel(joinedUsers: [nil], openedUser: self.user, offeredMeal: "Makaroni Peperoni"),OfferModel(joinedUsers: [nil], openedUser: self.user, offeredMeal: "Bertuğ Special")]
    }
    
    
}
extension SurveyOfferPresenter : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offers.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SurveyCell") as? SurveyCell{
                cell.survey = self.survey
                cell.isUserInteractionEnabled = false
                print("Hello Baba")
                return cell
            }
        }else{
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? SurveyOfferCell{
                cell.offer = self.offers[indexPath.row-1]
                print(cell.offer.offeredMeal)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    
}
protocol SurveyOfferDelegate {
    func addOffer(user:User)
    func giveVoteForOffer(user:User)
}
