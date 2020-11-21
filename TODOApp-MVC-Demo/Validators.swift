//
//  Validators.swift
//  TODOApp-MVC-Demo
//
//  Created by Mohamed Azooz on 11/21/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
import UIKit

class Validators {
    
    weak var viewSignIn: SignInVC!
    weak var viewSignUp: SignUpVC!
    

    private func validateFields (with email: String?, password: String?, view: UIView)->Bool {
        if !isValidEmail(email: email , view: view){
            return false
        }
        if !isValidPassword(password: password, view: view) {
            return false
        }
        return true
    }
    
    private func isValidEmail(email: String? , view: UIView) -> Bool {
        guard let email = email?.trimmed, !email.isEmpty else {
            if view == viewSignIn {
            self.viewSignIn.presentError(with: "Please Enter an Email")
            } else {
            self.viewSignUp.presentError(with: "Please Enter an Email")
            }
            return false
        }
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        if !pred.evaluate(with: email) {
            if view == viewSignIn {
                self.viewSignIn.presentError(with: "Please Enter Valid Email")
            } else {
                self.viewSignUp.presentError(with: "Please Enter Valid Email")
            }
            
            return false
        }
        return true
    }
    
    private func isValidPassword(password: String?, view: UIView) -> Bool {
        guard let password = password, !password.isEmpty, password.count >= 8 else {
            if view == viewSignIn {
            self.viewSignIn.presentError(with: "Password Must be at Least 8 Characters")
            } else {
            self.viewSignUp.presentError(with: "Password Must be at Least 8 Characters")
            }
            return false
        }
        return true
    }
}
