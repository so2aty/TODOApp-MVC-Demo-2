//
//  SignUpVC.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {

    @IBOutlet weak var NameText: UITextField!
    @IBOutlet weak var EmailText: UITextField!
    @IBOutlet weak var PasswordText: UITextField!
    @IBOutlet weak var AgeText: UITextField!
    
    var presenter : SignUpPresenter!
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    // MARK:- Public Methods
    class func create() -> SignUpVC {
        let signUpVC: SignUpVC = UIViewController.create(storyboardName: Storyboards.authentication, identifier: ViewControllers.signUpVC)
        signUpVC.presenter = SignUpPresenter(view: signUpVC)
        return signUpVC
    }
    
    func presentError(with message: String) {
       self.showAlert(title: "Sorry", message: message)
   }
   
    func showLoader() {
        self.view.showLoader()
    }
    
    func hideLoader() {
        self.view.hideLoader()
    }
    
    
     func switchToMainState() {
        let todoListVC = TodoListVC.create()
        let navigationController = UINavigationController(rootViewController: todoListVC)
        AppDelegate.shared().window?.rootViewController = navigationController
    }
    
    // MARK:- Private Methods
    
    @IBAction func SignUpButtonPressed(_ sender: UIButton) {
        presenter.tryToRegister(with: EmailText.text, password: PasswordText.text, name: NameText.text, Age: Int(AgeText.text!))

    }
}


