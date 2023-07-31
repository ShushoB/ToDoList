//
//  UITableViewCell.swift
//  To_Do
//
//  Created by Picsart Academy on 26.07.23.
//

import UIKit

final class ToDoTableViewCell: UITableViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(text: String) {
        titleLabel.text = text
    }
    
}

