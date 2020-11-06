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
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK:- Public Methods
    class func create() -> SignInVC {
        let signInVC: SignInVC = UIViewController.create(storyboardName: Storyboards.authentication, identifier: ViewControllers.signInVC)
        return signInVC
    }
    
    // MARK:- Private Methods
    private func isValidEmail(email: String?) -> Bool {
        guard let email = email?.trimmed, !email.isEmpty else {
            self.presentError(with: "Please Enter an Email")
            return false
        }
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        if !pred.evaluate(with: email) {
            self.presentError(with: "Please Enter Valid Email")
            return false
        }
        return true
    }
    
    private func isValidPassword(password: String?) -> Bool {
        guard let password = password, !password.isEmpty, password.count >= 8 else {
            self.presentError(with: "Password Must be at Least 8 Characters")
            return false
        }
        return true
    }
    
    private func presentError(with message: String) {
        self.showAlert(title: "Sorry", message: message)
    }
    
    private func switchToMainState() {
        let todoListVC = TodoListVC.create()
        let navigationController = UINavigationController(rootViewController: todoListVC)
        AppDelegate.shared().window?.rootViewController = navigationController
    }
    
    private func login(with email: String?, password: String?) {
        guard let email = email, self.isValidEmail(email: email) else {return}
        guard let password = password, self.isValidPassword(password: password) else {return}
        self.view.showLoader()
        APIManager.login(email: email, passowrd: password, completion: { (error, loginData) in
            if let error = error {
                self.presentError(with: error.localizedDescription)
            } else if let loginData = loginData {
                UserDefaultsManager.shared().token = loginData.token
                self.switchToMainState()
            }
            self.view.hideLoader()
        })
    }
    
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        guard self.isValidEmail(email: emailTextField.text) else {return}
        guard self.isValidPassword(password: passwordTextField.text) else {return}
        self.login(with: emailTextField.text, password: passwordTextField.text)
    }
}
