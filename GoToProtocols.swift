//
//  GoToProtocols.swift
//  TODOApp-MVC-Demo
//
//  Created by Mohamed Azooz on 12/5/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation

//1- Coordinator
protocol goToMain: class {
    func switchToMain()
}
protocol goToProfileDetails: class {
    func switchToProfile()
}
protocol goToSignIn: class {
    func switchToSignIn()
}
