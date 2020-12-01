//
//  SignInVC.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//
import UIKit

protocol SignInVCProtocol: class {
    func switchToMainState()
    func showLoader()
    func hideLoader()
    func presentError(with message: String)
}

class SignInVC: UIViewController {
    
    // MARK:- Outlets
    
    @IBOutlet var signInView: SignInView!
    
    // MARK:- Public Proprities
    var viewModel : signInViewModelProtocol!
    
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        signInView.setup()
    }
    
    // MARK:- Public Methods
    class func create() -> SignInVC {
        let signInVC: SignInVC = UIViewController.create(storyboardName: Storyboards.authentication, identifier: ViewControllers.signInVC)
        signInVC.viewModel = SignInViewModel(view: signInVC)
        return signInVC
    }
    
    // MARK:- Action
    
    @IBAction func signUpBtnTapped(_ sender: UIButton) {
        let signUpVC = SignUpVC.create()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        viewModel.tryToLogin(with:signInView.emailTextField.text,password:signInView.passwordTextField.text)
    }
    
    
}

extension SignInVC : SignInVCProtocol {
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
       let todoListVC = TodoListVC.create()
       let navigationController = UINavigationController(rootViewController: todoListVC)
       AppDelegate.shared().window?.rootViewController = navigationController
   }
    
}
