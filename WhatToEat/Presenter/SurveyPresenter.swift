//
//  SurveyPresenter.swift
//  WhatToEat
//
//  Created by Onur Hüseyin Çantay on 22.08.2018.
//  Copyright © 2018 Onur Hüseyin Çantay. All rights reserved.
//

import UIKit

class SurveyPresenter:NSObject {
    var surveyDelegate : SurveyDelegate
    let currentUser = User.loadUser()
    var surveys : [SurveyModel] = []
    let user = User(id:"1",name: "Onur", surname: "Çantay", email: "ohc3807@gmail.com", password: "123456", joinedDate:Date(), surveys: [nil], offers: [nil], profileImage: "www.bombabomba.com", finishedSurveys: [nil], acceptedOffers: [nil])
    init(delegate : SurveyDelegate) {
        self.surveyDelegate = delegate
    }
    
    func getAllSurveys(tableview:UITableView){
        Service.service.getSurveys { (status, surveys) in
            if status == false{
                print("An Error Ocurred")
                return
            }
            self.surveys = surveys as! [SurveyModel]
            tableview.reloadData()
        }
    }
    
}
extension SurveyPresenter:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.surveys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SurveyCell") as? SurveyCell{
            cell.survey = surveys[indexPath.row]
            print(cell.survey.description)
            return cell
        }
        return UITableViewCell()
    }
    
    
}

protocol SurveyDelegate {
    func offerSurvey()
    func postSurvey(surveyData:Dictionary<String,AnyObject>)
    func endSurvey()
    func showSurveyInfo(surveyId : Int) -> SurveyModel
    func switchSurveyChanel()
}
