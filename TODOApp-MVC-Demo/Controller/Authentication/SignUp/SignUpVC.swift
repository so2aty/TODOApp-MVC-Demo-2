//
//  SignUpVC.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

// MARK:-  Protocols

protocol SignUpProtocol: class{
    func switchToMainState()
    func showLoader()
    func hideLoader()
    func presentError(with message: String)
}

class SignUpVC: UIViewController {

    @IBOutlet var signUpView: SignUpView!
    
    
    // MARK:- Public Proprities
    var viewModel: signUpViewModelProtocol!
    weak var delegate: goToMain?
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        signUpView.setup()
    }
    

    // MARK:- Public Methods
    class func create() -> SignUpVC {
        let signUpVC: SignUpVC = UIViewController.create(storyboardName: Storyboards.authentication, identifier: ViewControllers.signUpVC)
        signUpVC.viewModel = SignUpViewModel(view: signUpVC)
        return signUpVC
    }
  
    
    // MARK:- Action

    @IBAction func SignUpButtonPressed(_ sender: UIButton) {
        viewModel.tryToRegister(with: signUpView.emailTextField.text, password:signUpView.passwordTextField.text, name: signUpView.nameTextField.text, age: Int(signUpView.ageTextField.text!))
    }
}

extension SignUpVC: SignUpProtocol {
    
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
        self.delegate?.switchToMain()
    }
    
}
