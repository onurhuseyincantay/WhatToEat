//
//  SurveysViewController.swift
//  WhatToEat
//
//  Created by Onur Hüseyin Çantay on 22.08.2018.
//  Copyright © 2018 Onur Hüseyin Çantay. All rights reserved.
//

import UIKit

class SurveyTableViewController: UITableViewController {
    private var surveyPresenter : SurveyPresenter!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.surveyPresenter = SurveyPresenter(delegate: self)
        self.surveyPresenter.getAllSurveys(tableview: self.tableView)
        self.setupTableView()
    }
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self.surveyPresenter
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let survey = self.showSurveyInfo(surveyId: indexPath.row)
        if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "SurveyOfferViewController") as? SurveyOfferViewController{
            viewController.survey = survey
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }

}
extension SurveyTableViewController:SurveyDelegate{
    func showSurveyInfo(surveyId: Int) -> SurveyModel {
        let survey = self.surveyPresenter.surveys[surveyId]
        return survey
    }
    
    func offerSurvey(user: User) {
        print("survey offered")
    }
    
    func postSurvey(user: User) {
        print("survey posted")
    }
    
    func endSurvey(user: User) {
        
        print("survey finished")
    }
    
    func switchSurveyChanel() {
        
        print("surveychanel switched")
    }
    
    
}
