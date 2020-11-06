//
//  DeletTaskResponse.swift
//  TODOApp-MVC-Demo
//
//  Created by Mohamed Azooz on 11/6/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
struct DeletTaskResponse: Codable {
    let success: Bool
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
}
