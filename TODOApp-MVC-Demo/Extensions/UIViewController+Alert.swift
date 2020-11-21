//
//  UIViewController+Alert.swift
//  TODOList-MVC-Demo
//
//  Created by IDEAcademy on 10/31/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, okTitle: String = "OK", okHandler: ((UIAlertAction)->Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: okTitle, style: .cancel, handler: okHandler))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithTextfield(title: String, message: String, okTitle: String = "Save", okHandler: @escaping((_ message: String?)->Void)) {

    
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Enter Your Age"
        }
        let okAction = UIAlertAction(title: okTitle, style: .default) { (action) in
            guard let textField = alert.textFields?[0].text else {return} // Force unwrapping because we know it exists.
            okHandler(textField)
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
