//
//  Validators.swift
//  TODOApp-MVC-Demo
//
//  Created by Mohamed Azooz on 11/21/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation

class Validators {
    
   //MARK:- Singleton
    
    private static let sharedInstance = Validators()
    
    class func shared() -> Validators {
        return Validators.sharedInstance
    }
    
    
    func isEmptyEmail(email: String?) -> Bool {
        guard let email = email?.trimmed, !email.isEmpty else {
            return false
        }
        return true
    }
    
    func isValidEmail(email: String?) -> Bool {
        
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        if !pred.evaluate(with: email) {
            return false
        }
        return true
    }
    
    func isValidPassword(password: String?) -> Bool {
        guard let password = password, !password.isEmpty, password.count >= 8 else {
            return false
        }
        return true
    }
}
