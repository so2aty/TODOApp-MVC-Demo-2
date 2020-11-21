//
//  SignInPresenter.swift
//  TODOApp-MVC-Demo
//
//  Created by Mohamed Azooz on 11/17/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation



class SignInPresenter {
    private var signInPresenterDelegate : SignInDelegation?
    
    
    init(signInPresenterDelegate: SignInDelegation?) {
        self.signInPresenterDelegate = signInPresenterDelegate
    }
}
