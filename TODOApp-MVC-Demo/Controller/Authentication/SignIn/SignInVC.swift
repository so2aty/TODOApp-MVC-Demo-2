//
//  SignInVC.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//
import UIKit

class SignInVC: UIViewController {
    
    // MARK:- Outlets
    
   
    @IBOutlet var signInView: SignInView!
    
    var presenter : SignInPresenter!
    
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        signInView.setup()
    }
    
    // MARK:- Public Methods
    class func create() -> SignInVC {
        let signInVC: SignInVC = UIViewController.create(storyboardName: Storyboards.authentication, identifier: ViewControllers.signInVC)
        signInVC.presenter = SignInPresenter(view: signInVC)
        return signInVC
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
    
    
    // MARK:- Action
    
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        presenter.tryToLogin(with:signInView.emailTextField.text,password:signInView.passwordTextField.text)
    }
    
    
}
