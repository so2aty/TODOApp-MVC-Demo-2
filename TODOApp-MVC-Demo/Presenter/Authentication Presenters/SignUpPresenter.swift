//
//  SignUpPresenter.swift
//  TODOApp-MVC-Demo
//
//  Created by Mohamed Azooz on 11/20/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation

class SignUpPresenter {
    
    weak var view: SignUpVC!
    
    init(view: SignUpVC) {
        self.view = view
    }
    
    // MARK:- Privet Methods
    
    private func validateFields (with email: String?, password: String?)->Bool {
        if !Validators.shared().isEmptyEmail(email: email){
            self.view.presentError(with: "Please Enter An Email")
            return false
        }
        if !Validators.shared().isValidEmail(email: email){
            self.view.presentError(with: "Please Enter Valid Email")
            return false
        }
        if !Validators.shared().isValidPassword(password: password){
            self.view.presentError(with: "Please Enter Valid Password")
            return false
        }
        return true
    }
    
//    private func isValidEmail(email: String?) -> Bool {
//        guard let email = email?.trimmed, !email.isEmpty else {
//            self.view.presentError(with: "Please Enter an Email")
//            return false
//        }
//        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
//        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
//        if !pred.evaluate(with: email) {
//            self.view.presentError(with: "Please Enter Valid Email")
//            return false
//        }
//        return true
//    }
//
//    private func isValidPassword(password: String?) -> Bool {
//        guard let password = password, !password.isEmpty, password.count >= 8 else {
//            self.view.presentError(with: "Password Must be at Least 8 Characters")
//            return false
//        }
//        return true
//    }
    
    private func Register(with email: String?, password: String? , name: String? , age: Int? ) {
        self.view.showLoader()
        APIManager.Register(email: email!, password: password!, name: name!, age: age!) { (response)  in
            switch response {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let result):
                UserDefaultsManager.shared().token = result.token
                self.view.switchToMainState()
            }
            self.view.hideLoader()
        }
    }
}
// MARK:- Public Methods
extension SignUpPresenter {
    func tryToRegister(with email: String?, password: String? , name: String? , age: Int? ) {
        if validateFields(with: email, password: password) {
            Register(with: email, password: password, name: name, age: age)
        }
    }
}

