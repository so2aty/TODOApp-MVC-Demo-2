//
//  TodoListPresenter.swift
//  TODOApp-MVC-Demo
//
//  Created by Mohamed Azooz on 11/20/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
protocol ToDoListViewModelProtocol {
    func addTask (newTask: String)
    func loadAllTodos()
    func deletTask (id : String)
}

class ToDoListViewModel {
    
    var view: todoListVCProtocol!
    var tasks = [TodoData]()
    init(view: todoListVCProtocol) {
        self.view = view
    }
   
}

extension ToDoListViewModel: ToDoListViewModelProtocol {
    func loadAllTodos() {
        self.view.showLoader()
        APIManager.getAllTodos { (response) in
            switch response {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let result):
                self.tasks = result.data
                self.view.todoList().tableView.reloadData()
            }
            self.view.hideLoader()
        }
    }
    func deletTask (id : String) {
        APIManager.deletTask(id: id) { (error, data) in
            if error == nil {
                self.loadAllTodos()
            }
        }
    }
    func addTask (newTask: String) {
        APIManager.addTask(descriptionn: newTask) { (error, data) in
            if let error = error {
                print(error.localizedDescription)
            } else if let taskData = data {
                self.loadAllTodos()
            }
        }
    }
}
