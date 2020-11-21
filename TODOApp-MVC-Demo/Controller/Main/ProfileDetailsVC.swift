//
//  ProfileDetails.swift
//  TODOApp-MVC-Demo
//
//  Created by Mohamed Azooz on 11/6/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class ProfileDetailsVC: UITableViewController, UINavigationControllerDelegate {
    // MARK:- Outlets
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var emailLable: UILabel!
    @IBOutlet weak var agelable: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    // MARK: - Public Properties
    let imagePicker = UIImagePickerController()
    var presenter : ProfileDetailsPresenter!
    
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        presenter.loadUserData()
    }
   
    // MARK:- Public Methods
    class func create() -> ProfileDetailsVC {
        let profileDetailsVC: ProfileDetailsVC = UIViewController.create(storyboardName: Storyboards.main, identifier: ViewControllers.todoListVC)
        profileDetailsVC.presenter = ProfileDetailsPresenter(view: profileDetailsVC)
        return profileDetailsVC
    }
    
    func switchToMainState() {
        let signInVC = SignInVC.create()
        let navigationController = UINavigationController(rootViewController: signInVC)
        AppDelegate.shared().window?.rootViewController = navigationController
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
            presenter.editAge()
        }
    }
    
    
    // MARK:- Private Methods
    
    @IBAction func logoutBottonPressed(_ sender: UIButton) {
        presenter.logOut()
    }
    
    @IBAction func addPhotoButtonPressed(_ sender: Any) {
        presenter.addPhoto()
        present(imagePicker, animated: true, completion: nil)
    }
}
// MARK: - Image Picker Extension.

extension ProfileDetailsVC:UIImagePickerControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileImageView.contentMode = .scaleAspectFit
            profileImageView.image = pickedImage
            APIManager.uploadPhoto(with: pickedImage){ (response) in
                if  response == false {
                    print("error")
                } else  {
                    print("ok")
                }
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
