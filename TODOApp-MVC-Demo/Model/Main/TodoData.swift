//
//  TodoData.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 11/3/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation

struct TodoData: Codable {
    let description: String
    let id : String
    
    
    enum CodingKeys: String, CodingKey {
        case description
        case id = "_id"
    }
}
