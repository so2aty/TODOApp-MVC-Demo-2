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
    
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    // MARK:- Public Methods
    class func create() -> SignUpVC {
        let signUpVC: SignUpVC = UIViewController.create(storyboardName: Storyboards.authentication, identifier: ViewControllers.signUpVC)
        return signUpVC
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
    
    private func Register(with email: String?, password: String? , name: String? , Age: Int? ) {
        guard let email = email, self.isValidEmail(email: email) else {return}
        guard let password = password, self.isValidPassword(password: password) else {return}
        guard let name = name else {return}
        guard let age = Age else {return}
        self.view.showLoader()
        APIManager.Register(email: email, passowrd: password, name: name, age: age, completion: { (error, loginData ) in
            if let error = error {
                self.presentError(with: error.localizedDescription)
            } else if let loginData = loginData {
                UserDefaultsManager.shared().token = loginData.token
                self.switchToMainState()
            }
            self.view.hideLoader()
        })
    }
    @IBAction func SignUpButtonPressed(_ sender: UIButton) {
        guard self.isValidEmail(email: EmailText.text) else {return}
        guard self.isValidPassword(password: PasswordText.text) else {return}
        self.Register(with: EmailText.text, password: PasswordText.text, name: NameText.text, Age: Int(AgeText.text!))
    }
}

