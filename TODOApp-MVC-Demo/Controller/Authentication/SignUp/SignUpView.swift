//
//  SignUpView.swift
//  TODOApp-MVC-Demo
//
//  Created by Mohamed Azooz on 11/25/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class SignUpView: UIView {

    // MARK:- Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var backGroundImage: UIImageView!
    @IBOutlet weak var signUpLabel: UILabel!
    
    // MARK:- Public Method
    func setup(){
        setupBackGround()
        setupTextField(nameTextField, placeHolder: "Your Name")
        setupTextField(emailTextField, placeHolder: "Email")
        setupTextField(passwordTextField, placeHolder: "Password",isSceure: true)
        setupTextField(ageTextField, placeHolder: "Your Age")
        setupSignUpButton()
        signUpLabel.text = "Sign Up"
    }
    
}

// MARK:- Private Method
extension SignUpView {
    private func setupBackGround(){
        backGroundImage.image = #imageLiteral(resourceName: "background 2")
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
    private func setupSignUpButton(){
        signUpButton.backgroundColor = .purple
        signUpButton.layer.cornerRadius = signUpButton.frame.height / 2
        signUpButton.setTitle("Sign Up", for: .normal)
    }
    
}

