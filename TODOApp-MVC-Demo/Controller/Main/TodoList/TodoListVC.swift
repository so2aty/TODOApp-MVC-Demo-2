//
//  ViewController.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit
protocol todoListVCProtocol {
    func showLoader()
    func hideLoader()
    func presentError(with message: String)
    func todoList () -> TodoListView
    func showAlret ()
    
}
class TodoListVC: UIViewController {
    // MARK:- Outlets
 
    @IBOutlet var todoListView: TodoListView!
    
    // MARK: - Public Properties
    var todosArr: [TodoData] = []
    var viewModel: ToDoListViewModelProtocol!
    weak var profileDelegate: goToProfileDetails?
    
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModel.loadAllTodos()
        print(todosArr.count)
    }
    
    override func viewWillAppear(_ animated: Bool) {
      // viewModel.loadAllTodos()
    }

    
    // MARK:- Public Methods
    class func create() -> TodoListVC {
        let todoListVC: TodoListVC = UIViewController.create(storyboardName: Storyboards.main, identifier: ViewControllers.todoListVC)
        todoListVC.viewModel = ToDoListViewModel(view: todoListVC)
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
        self.todoListView.tableView.register(UINib.init(nibName: Cells.todoCell, bundle: nil), forCellReuseIdentifier: Cells.todoCell)
        self.todoListView.tableView.dataSource = self
        self.todoListView.tableView.delegate = self
        self.todoListView.tableView.separatorStyle = .none
        self.todoListView.tableView.backgroundColor = UIColor.clear
        self.todoListView.tableView.isOpaque = false
    }
  
    
    
    // MARK:- Action
    @objc func addingButtonPressed() {
        showAlret()
    }
    
    
    @IBAction func profileBtnTapped(_ sender: UIBarButtonItem) {
        self.profileDelegate?.switchToProfile()
//        let profileVC = ProfileDetailsVC.create()
//        navigationController?.pushViewController(profileVC, animated: true)
    }
    
}

// MARK: - Table view data source & delegate

extension TodoListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sendTasks().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cells.todoCell, for: indexPath) as? TodoCell else {
            return UITableViewCell()
        }
        
        cell.configure(todo:viewModel.sendTasks()[indexPath.row].description)
        
        cell.deleteCompletion = { [weak self] cell in
            guard let id = self?.todosArr[indexPath.row].id else {return}
            self?.viewModel.deletTask (id : id)
//            APIManager.deletTask(id: id) { (error, data) in
//                if error == nil {
//                    self?.viewModel.loadAllTodos()
//                }
//            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

}
extension TodoListVC: todoListVCProtocol {
    
    
    func showAlret() {
        self.showAlertWithTextfield(title: "Add New Task", message: "Please Enter Your Task", okTitle: "ADD") { (task) in
            if let newTask = task, !(task!.isEmpty) {
                self.viewModel.addTask(newTask: newTask)
            }
        }
    }
    
    func todoList () -> TodoListView{
        return todoListView
    }
    
    func showLoader() {
        self.view.showLoader()
    }
    
    func hideLoader() {
        self.view.hideLoader()
    }
    func presentError(with message: String) {
        self.showAlert(title: "Sorry", message: message)
    }
    
}
