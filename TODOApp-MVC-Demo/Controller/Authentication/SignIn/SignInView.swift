//
//  SignInView.swift
//  TODOApp-MVC-Demo
//
//  Created by Mohamed Azooz on 11/25/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class SignInView: UIView {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var dontHaveLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var backGroundImage: UIImageView!
    @IBOutlet weak var loginLabel: UILabel!
    
    // MARK:- Public Method
    func setup(){
        setupBackGround()
        setupTextField(emailTextField, placeHolder: "Email")
        setupTextField(passwordTextField, placeHolder: "Password",isSceure: true)
        setupSignInButton()
        setupSignUpButton()
        dontHaveLabel.text = "Don't have an account?"
        loginLabel.text = "Login"
    }
}

// MARK:- Private Method
extension SignInView {
    private func setupBackGround(){
        backGroundImage.image = #imageLiteral(resourceName: "background 2-1")
    }
    private func setupTextField(_ textField: UITextField, placeHolder: String, isSceure: Bool = false, isPhone: Bool = false){
        textField.backgroundColor = .white
        textField.placeholder = placeHolder
        textField.font = UIFont.init(name: passwordTextField.font!.fontName, size: 20)
        textField.isSecureTextEntry = isSceure
        if isPhone {
            textField.keyboardType = .asciiCapableNumberPad
        }
    }
    private func setupSignInButton(){
        loginButton.backgroundColor = .purple
        loginButton.layer.cornerRadius = signUpButton.frame.height / 2
        loginButton.setTitle("Sign In", for: .normal)
    }
    
    private func setupSignUpButton(){
        signUpButton.layer.cornerRadius = signUpButton.frame.height / 2
        signUpButton.setTitle("Sign Up", for: .normal)
    }
    
    
}
