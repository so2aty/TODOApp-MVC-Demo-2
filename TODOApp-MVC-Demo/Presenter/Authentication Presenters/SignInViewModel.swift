//
//  SignInPresenter.swift
//  TODOApp-MVC-Demo
//
//  Created by Mohamed Azooz on 11/20/20.
//  Copyright © 2020 IDEAEG. All rights reserved.


import Foundation

protocol  signInViewModelProtocol  {
    func tryToLogin(with email: String?, password: String?)
}

class SignInViewModel {
    
    weak var view: SignInVCProtocol!
    init(view: SignInVCProtocol) {
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
//
    private func login(with email: String?, password: String?) {
        self.view.showLoader()
        APIManager.login(email: email!, password: password!) { (response) in
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
extension SignInViewModel : signInViewModelProtocol {
    func tryToLogin(with email: String?, password: String?) {
        if validateFields(with: email, password: password) {
            login(with: email, password: password)
        }
    }
}
