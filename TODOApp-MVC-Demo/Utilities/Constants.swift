//
//  Constants.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation


// Storyboards
struct Storyboards {
    static let authentication = "Authentication"
    static let main = "Main"
}

// View Controllers
struct ViewControllers {
    static let signUpVC = "SignUpVC"
    static let signInVC = "SignInVC"
    static let todoListVC = "TodoListVC"
    static let profileDetailsVC = "ProfileDetailsVC"
}

// Cells
struct Cells {
    static let todoCell = "TodoCell"
    static let profileCell = "Name_Image"
}

// Urls
struct URLs {
    static let base = "https://api-nodejs-todolist.herokuapp.com"
    static let login = "/user/login"
    static let Register = "/user/register"
    static let todos = "/task"
    static let delet = base + "/task/"
    static let userDetails = base +  "/user/me"
    static let logout = "/user/logout"
    static let EditProfile = base + "/user/me"
    static let uploadPhoto = base + "/user/me/avatar"
}

// Header Keys
struct HeaderKeys {
    static let contentType = "Content-Type"
    static let authorization = "Authorization"
}

// Parameters Keys
struct ParameterKeys {
    static let email = "email"
    static let password = "password"
    static let name = "name"
    static let age = "age"
}

// UserDefaultsKeys
struct UserDefaultsKeys {
    static let token = "UDKToken"
    static let id = "id"
}
