//
//  TaskCell.swift
//  WebServicesDemo
//
//  Created by FARIDO on 1/8/18.
//  Copyright © 2018 FARIDO. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .clear
    }

    func configerCell(task: Task) {
        textLabel?.text = task.task
        backgroundColor = task.completed ? .yellow: .clear
    }
}
