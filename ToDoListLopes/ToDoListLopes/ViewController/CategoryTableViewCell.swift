//
//  CategoryTableViewCell.swift
//  ToDoListLopes
//
//  Created by user226225 on 1/8/23.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var LabelName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
