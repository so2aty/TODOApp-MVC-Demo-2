//
//  SignUpVC.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {

    @IBOutlet var signUpView: SignUpView!
    
    var presenter: SignUpPresenter!
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        signUpView.setup()
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
        presenter.tryToRegister(with: signUpView.emailTextField.text, password:signUpView.passwordTextField.text, name: signUpView.nameTextField.text, Age: Int(signUpView.ageTextField.text!))

    }
}


