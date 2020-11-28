//
//  TaskData.swift
//  TODOApp-MVC-Demo
//
//  Created by Mohamed Azooz on 11/28/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//


import Foundation

struct TaskData: Codable {
    let completed: Bool
    let id, dataDescription, owner, createdAt: String
    let updatedAt: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case completed
        case id = "_id"
        case dataDescription = "description"
        case owner, createdAt, updatedAt
        case v = "__v"
    }
}
