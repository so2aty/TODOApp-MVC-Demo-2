//
//  File.swift
//  TODOApp-MVC-Demo
//
//  Created by Mohamed Azooz on 11/20/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
import UIKit

protocol ProfileViewModelProtocol {
    func logOut()
    func loadUserData()
    func uploadPhoto (pikedImage : UIImage )
    func editAge (newAge : Int)
//    func addPhoto ()
}

class ProfileDetailsViewModel {
    
    var view: ProfileDetailsVCProtocol!
    
    init ( view: ProfileDetailsVCProtocol) {
        self.view = view
    }
    
    
    // MARK:- Public Methods
    
//    
//    func pickImage (image : UIImage) {
//        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            view.profileImageView.contentMode = .scaleAspectFit
//            view.profileImageView.image = pickedImage
//            APIManager.uploadPhoto(with: pickedImage){ (response) in
//                if  response == false {
//                    print("error")
//                } else  {
//                    print("ok")
//                }
//            }
//        }
//        view.dismiss(animated: true, completion: nil)
//    }
//
}

extension ProfileDetailsViewModel: ProfileViewModelProtocol {
    
    
    func logOut() {
        APIManager.logout { (response) in
            switch response {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let result):
                self.view.switchToAuthState()
                print("done")
            }
        }
    }
    
    func loadUserData() {
        APIManager.getUserDetails { (error, userData) in
            if let error = error {
                print(error.localizedDescription)
            } else if let userData = userData {
                
                self.view.profileDetailsView().nameLable.text = userData.name
                self.view.profileDetailsView().emailLable.text = userData.email
                self.view.profileDetailsView().agelable.text = String(userData.age)
                self.view.profileDetailsView().reloadData()
            }
        }
    }
    
    func uploadPhoto (pikedImage : UIImage ) {
        APIManager.uploadPhoto(with: pikedImage){ (response) in
        if  response == false {
            print("error")
        } else  {
            print("ok")
        }
    }
    }
    
    func editAge (newAge : Int) {
        APIManager.EditProfile(age: String(newAge)) { (error , userdata) in
            if let error = error {
                print(error.localizedDescription)
            } else if let userData = userdata {
                self.view.profileDetailsView().agelable.text = String(newAge)
            }
        }
    }
    
//    func addPhoto () {
//        view.imagePicker.allowsEditing = true
//        view.imagePicker.sourceType = .photoLibrary
//    }
}
