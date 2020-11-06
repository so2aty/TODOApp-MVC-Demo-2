//
//  ViewController.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class TodoListVC: UIViewController {
    // MARK:- Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Private Properties
    private var todosArr: [String] = []
    
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        loadAllTodos()
    }

    // MARK:- Public Methods
    class func create() -> TodoListVC {
        let todoListVC: TodoListVC = UIViewController.create(storyboardName: Storyboards.main, identifier: ViewControllers.todoListVC)
        return todoListVC
    }
    
    // MARK:- Private Methods
    private func setupViews() {
        setupNavbar()
        setupTableView()
    }
    
    private func setupNavbar() {
        let addingButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addingButtonPressed))
        self.navigationItem.leftBarButtonItem = addingButton
    }
    
    private func setupTableView() {
        self.tableView.register(UINib.init(nibName: Cells.todoCell, bundle: nil), forCellReuseIdentifier: Cells.todoCell)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorStyle = .none
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.isOpaque = false
    }
    
    @objc func addingButtonPressed() {
        print("add")
    }
    
    private func presentError(with message: String) {
        self.showAlert(title: "Sorry", message: message)
    }
    
    private func loadAllTodos() {
        self.view.showLoader()
        APIManager.getAllTodos { (error, todosDataArr) in
            if let error = error {
                self.presentError(with: error.localizedDescription)
            } else if let todosDataArr = todosDataArr {
                var todosDescriptionArr: [String] = []
                for todo in todosDataArr {
                    todosDescriptionArr.append(todo.description)
                }
                self.todosArr = todosDescriptionArr
                self.tableView.reloadData()
            }
            self.view.hideLoader()
        }
    }
}

extension TodoListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todosArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cells.todoCell, for: indexPath) as? TodoCell else {
            return UITableViewCell()
        }
        
        cell.configure(todo: todosArr[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
