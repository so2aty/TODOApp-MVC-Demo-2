//
//  AppStateManager.swift
//  TODOList-MVC-Demo
//
//  Created by IDEAcademy on 12/1/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
import UIKit

protocol AppStateManagerProtocol {
    func start(appDelegate: AppDelegateProtocol)
}

class AppStateManager {
    
    // MARK:- Properties
    var appDelegate: AppDelegateProtocol!
    var mainWindow: UIWindow? {
        return self.appDelegate?.getMainWindow()
    }
    
    // MARK:- AppState Enum
    enum AppState {
        case none
        case main
        case signIn
        case profile
        
    }
    
    var state: AppState = .none {
        willSet(newState) {
            switch newState {
            case .signIn:
                switchToSignInState()
            case .main:
                switchToMainState()
            case .profile:
                switchToProfileState()
                
            default:
                return
            }
        }
    }
    
    // MARK:- Singleton
    private static let sharedInstance = AppStateManager()
    
    class func shared() -> AppStateManager {
        return AppStateManager.sharedInstance
    }
    
    
    func switchToMainState() {
        let todoListVC = TodoListVC.create()
        todoListVC.profileDelegate = self
        let navigationController = UINavigationController(rootViewController: todoListVC)
        self.mainWindow?.rootViewController = navigationController
    }
    
    func switchToSignInState() {
        let signInVC = SignInVC.create()
        // 4-
        signInVC.delegate = self
        let navigationController = UINavigationController(rootViewController: signInVC)
        self.mainWindow?.rootViewController = navigationController
    }
    
    func switchToProfileState() {
        let profileVC = ProfileDetailsVC.create()
        // 4-
        profileVC.signInDelegate = self
        
        let navigationController = UINavigationController(rootViewController: profileVC)
        self.mainWindow?.rootViewController = navigationController
    }
       
}


extension AppStateManager: AppStateManagerProtocol {
    func start(appDelegate: AppDelegateProtocol) {
        self.appDelegate = appDelegate
    
        if UserDefaultsManager.shared().token != nil {
            self.state = .main
        } else {
            self.state = .signIn
        }
    }
}

// 5-
extension AppStateManager: goToMain {
    func switchToMain() {
        self.state = .main
    }
}

extension AppStateManager: goToProfileDetails {
    func switchToProfile() {
        self.state = .profile
    }
}

extension AppStateManager: goToSignIn {
    func switchToSignIn() {
            self.state = .signIn
        }

}



