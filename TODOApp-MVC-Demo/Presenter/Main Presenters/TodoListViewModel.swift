//
//  TodoListPresenter.swift
//  TODOApp-MVC-Demo
//
//  Created by Mohamed Azooz on 11/20/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
protocol ToDoListViewModelProtocol {
    func addTask ()
}

class ToDoListViewModel {
    
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
                self.view.todoListView.tableView.reloadData()
            }
            self.view.hideLoader()
        }
    }
    
    func addTask () {
        view.showAlertWithTextfield(title: "Add New Task", message: "Please Enter Your Task", okTitle: "ADD") { (task) in
            if let newTask = task, !(task!.isEmpty) {
                APIManager.addTask(descriptionn: newTask) { (error, data) in
                    if let error = error {
                        print(error.localizedDescription)
                    } else if let taskData = data {
                        self.loadAllTodos()
                    }
                }
            }
        }
    }
}
