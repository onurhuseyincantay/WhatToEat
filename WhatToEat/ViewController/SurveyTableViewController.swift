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
        let user = User.getUser()
        print(user?.id)
        print(user?.surname)
        print(user?.email)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavigationControllerBarButtonItems()
    }
    
    private func setupNavigationControllerBarButtonItems(){
        let rightButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(postSurvey))
        self.navigationController?.navigationBar.topItem?.setRightBarButton(rightButton, animated: true)
        
    }
    
    private func setupTableView() {
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
    
    func offerSurvey() {
        print("survey offered")
    }
    
    @objc func postSurvey(surveyData:Dictionary<String,AnyObject>) {
        Service.service.createSurvey(userId:"", surveyData: surveyData)
    }
    
    func endSurvey() {
        
        print("survey finished")
    }
    
    func switchSurveyChanel() {
        
        print("surveychanel switched")
    }
    
    
}
