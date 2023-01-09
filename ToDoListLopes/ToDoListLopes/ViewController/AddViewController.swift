//
//  AddViewController.swift
//  ToDoListLopes
//
//  Created by user226225 on 1/7/23.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var date: UIDatePicker!
    @IBOutlet weak var desc: UITextField!
    @IBOutlet weak var titre: UITextField!
    @IBOutlet weak var dateDuTo: UIDatePicker!
    
    var data : ToDo? = ToDo()
    override func viewDidLoad() {
        super.viewDidLoad()
        desc.delegate = self
        titre.delegate = self
        
        
    }
    
    @IBAction func datePickerChanged(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        let selectedDate = dateDuTo.date
        data?.duTo = selectedDate
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        data?.nom = titre.text!
        data?.desc = desc.text!
        return true
    }
}
