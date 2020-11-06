//
//  String+trimming.swift
//  TODOList-MVC-Demo
//
//  Created by IDEAcademy on 10/31/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation

extension String {
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
