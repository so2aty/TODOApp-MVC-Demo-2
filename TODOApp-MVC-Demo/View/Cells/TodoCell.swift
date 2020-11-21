//
//  TodoCell.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 11/3/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit


class TodoCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    
    var deleteCompletion: ((_ cell: TodoCell) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(todo: String) {
        descriptionLabel.text = todo
    }
    @IBAction func deletButtonPressed(_ sender: UIButton) {
        deleteCompletion?(self)
    }

}
