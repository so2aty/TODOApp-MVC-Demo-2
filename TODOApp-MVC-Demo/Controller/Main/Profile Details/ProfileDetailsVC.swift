//
//  ProfileDetails.swift
//  TODOApp-MVC-Demo
//
//  Created by Mohamed Azooz on 11/6/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit
// MARK: - Protocol
protocol ProfileDetailsVCProtocol {
    func switchToAuthState()
    func profileDetailsView () -> ProfileDetailsView
    
}
protocol switchToLogin: class {
    func showAuthState()
}
class ProfileDetailsVC: UITableViewController, UINavigationControllerDelegate {
    // MARK:- Outlets
    @IBOutlet var profileView: ProfileDetailsView!
    
    // MARK: - Public Properties
    let imagePicker = UIImagePickerController()
    var viewModel : ProfileViewModelProtocol!
    weak var signInDelegate: goToSignIn?
    
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        viewModel.loadUserData()
    }
   
    // MARK:- Public Methods
    class func create() -> ProfileDetailsVC {
        let profileDetailsVC: ProfileDetailsVC = UIViewController.create(storyboardName: Storyboards.main, identifier: ViewControllers.profileDetailsVC)
        profileDetailsVC.viewModel = ProfileDetailsViewModel(view: profileDetailsVC)
        return profileDetailsVC
    }
    
    func switchToAuthState() {
        self.signInDelegate?.switchToSignIn()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.showAlertWithTextfield(title: "Edit Profile", message: "Please Enter Your Age", okTitle: "Save") { (myAge) in
                if let age = myAge, !(age.isEmpty) {
                    self.viewModel.editAge(newAge: Int(age)!)
                }
            }
        }
    }
    
    
    // MARK:- Private Methods
    
    @IBAction func logoutBottonPressed(_ sender: UIButton) {
        viewModel.logOut()
    }
    
    @IBAction func addPhotoButtonPressed(_ sender: Any) {
       // viewModel.addPhoto()
        present(imagePicker, animated: true, completion: nil)
    }
}
// MARK: - Image Picker Extension.

extension ProfileDetailsVC:UIImagePickerControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileView.profileImageView.contentMode = .scaleAspectFit
            profileView.profileImageView.image = pickedImage
            viewModel.uploadPhoto(pikedImage: pickedImage)
            
//            APIManager.uploadPhoto(with: pickedImage){ (response) in
//                if  response == false {
//                    print("error")
//                } else  {
//                    print("ok")
//                }
//            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension ProfileDetailsVC: ProfileDetailsVCProtocol {
    func profileDetailsView() -> ProfileDetailsView {
        return profileView
    }
    
    
}
