//
//  TodoListPresenter.swift
//  TODOApp-MVC-Demo
//
//  Created by Mohamed Azooz on 11/20/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation

class ToDoListPresenter {
    
    weak var view: TodoListVC!
    
    init(view: TodoListVC) {
        self.view = view
    }
    
    // MARK:- Public Methods
    func loadAllTodos() {
        self.view.showLoader()
        APIManager.getAllTodos { (response) in
            switch response {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let result):
                self.view.todosArr = result.data
                self.view.tableView.reloadData()
            }
            self.view.hideLoader()
        }
    }
}
