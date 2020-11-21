//
//  File.swift
//  TODOApp-MVC-Demo
//
//  Created by Mohamed Azooz on 11/20/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
import UIKit

class ProfileDetailsPresenter {
    
    weak var view: ProfileDetailsVC!
    
    init ( view: ProfileDetailsVC) {
        self.view = view
    }
    
    
    // MARK:- Public Methods
    func logOut() {
        APIManager.logout { (response) in
            switch response {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let result):
                self.view.switchToMainState()
            }
        }
    }
    
    func loadUserData() {
        APIManager.getUserDetails { (error, userData) in
            if let error = error {
                print(error.localizedDescription)
            } else if let userData = userData {
                
                self.view.nameLable.text = userData.name
                self.view.emailLable.text = userData.email
                self.view.agelable.text = String(userData.age)
                self.view.tableView.reloadData()
            }
        }
    }
    
    func editAge () {
        view.showAlertWithTextfield(title: "Edit Profile", message: "Please Enter Your Age", okTitle: "Save") { (myAge) in
            if let age = myAge, !(age.isEmpty) {
                APIManager.EditProfile(age: age) { (error , userdata) in
                    if let error = error {
                        print(error.localizedDescription)
                    } else if let userData = userdata {
                        self.view.agelable.text = age
                    }
                }
            }
        }
    }
    
    func addPhoto () {
        view.imagePicker.allowsEditing = true
        view.imagePicker.sourceType = .photoLibrary
    }
    
    func pickImage (_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            view.profileImageView.contentMode = .scaleAspectFit
            view.profileImageView.image = pickedImage
            APIManager.uploadPhoto(with: pickedImage){ (response) in
                if  response == false {
                    print("error")
                } else  {
                    print("ok")
                }
            }
        }
        view.dismiss(animated: true, completion: nil)
    }
    

   
}
