//
//  ProfileDetails.swift
//  TODOApp-MVC-Demo
//
//  Created by Mohamed Azooz on 11/6/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class ProfileDetailsVC: UITableViewController {

   
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var emailLable: UILabel!
    @IBOutlet weak var agelable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadUserDetails()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    // MARK:- Private Methods
    
    private func loadUserDetails() {
        APIManager.getUserDetails { (error, userData) in
            if let error = error {
                print("error")
            } else if let userData = userData {
                
                self.nameLable.text = userData.name
                self.emailLable.text = userData.email
                self.agelable.text = String(userData.age)
                self.tableView.reloadData()
        }
    }
    
}
    
    private func switchToMainState() {
        let signInVC = SignInVC.create()
        let navigationController = UINavigationController(rootViewController: signInVC)
        AppDelegate.shared().window?.rootViewController = navigationController
    }
    
    @IBAction func logoutBottonPressed(_ sender: UIButton) {
        APIManager.logOut { (error, logoutData) in
            if let error = error {
                print("error")
            } else if let logoutData = logoutData {
                self.switchToMainState()
        }
    }
}

}
