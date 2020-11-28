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
 
    @IBOutlet var todoListView: TodoListView!
    
    // MARK: - Public Properties
    var todosArr: [TodoData] = []
    var presenter : ToDoListPresenter!
    
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        presenter.loadAllTodos()
    }

    
    // MARK:- Public Methods
    class func create() -> TodoListVC {
        let todoListVC: TodoListVC = UIViewController.create(storyboardName: Storyboards.main, identifier: ViewControllers.todoListVC)
        todoListVC.presenter = ToDoListPresenter(view: todoListVC)
        return todoListVC
    }
    
    func showLoader() {
        self.view.showLoader()
    }
    
    func hideLoader() {
        self.view.hideLoader()
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
        self.todoListView.tableView.register(UINib.init(nibName: Cells.todoCell, bundle: nil), forCellReuseIdentifier: Cells.todoCell)
        self.todoListView.tableView.dataSource = self
        self.todoListView.tableView.delegate = self
        self.todoListView.tableView.separatorStyle = .none
        self.todoListView.tableView.backgroundColor = UIColor.clear
        self.todoListView.tableView.isOpaque = false
    }
    private func presentError(with message: String) {
        self.showAlert(title: "Sorry", message: message)
    }
    
    
    // MARK:- Action
    @objc func addingButtonPressed() {
        presenter.addTask()
    }
    
    
    @IBAction func profileBtnTapped(_ sender: UIBarButtonItem) {
        let profileVC = ProfileDetailsVC.create()
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
}

// MARK: - Table view data source & delegate

extension TodoListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todosArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cells.todoCell, for: indexPath) as? TodoCell else {
            return UITableViewCell()
        }
        
        cell.configure(todo: todosArr[indexPath.row].description)
        
        cell.deleteCompletion = { [weak self] cell in
            guard let id = self?.todosArr[indexPath.row].id else {return}
            APIManager.deletTask(id: id) { (error, data) in
                if error == nil {
                    self?.presenter.loadAllTodos()
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

}
