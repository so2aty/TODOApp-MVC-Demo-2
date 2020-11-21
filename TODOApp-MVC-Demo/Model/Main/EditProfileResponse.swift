//
//  EditProfileResponse.swift
//  TODOApp-MVC-Demo
//
//  Created by Mohamed Azooz on 11/9/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation

struct EditProfileResponse: Codable {
    let success: Bool
    let data: UserData
}
