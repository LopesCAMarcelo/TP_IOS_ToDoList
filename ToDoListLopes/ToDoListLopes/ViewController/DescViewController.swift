//
//  DescViewController.swift
//  ToDoListLopes
//
//  Created by user226225 on 1/7/23.
//

import UIKit

class DescViewController: UIViewController {

    var data:ToDo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        desc.lineBreakMode = .byWordWrapping
        desc.numberOfLines = 0
        
        if let todo = data{
            titre.text = todo.nom
            desc.text = todo.desc
            
            let selectedDate = todo.duTo
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
            duTo.text = "To Do for : "+dateFormatter.string(from: selectedDate)
    
        }
        else{
            titre.text = "ERROR"
            desc.text = ""
            duTo.text = ""
        }
    }
    
    @IBOutlet weak var titre: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var duTo: UILabel!
}
