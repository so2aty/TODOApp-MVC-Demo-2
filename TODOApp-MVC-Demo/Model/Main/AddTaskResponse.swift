//
//  AddTaskResponse.swift
//  TODOApp-MVC-Demo
//
//  Created by Mohamed Azooz on 11/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation

struct AddTaskResponse: Codable {
    let success: Bool
    let data: TaskData
    
    enum CodingKeys: String, CodingKey {
        case success, data
    }
}

