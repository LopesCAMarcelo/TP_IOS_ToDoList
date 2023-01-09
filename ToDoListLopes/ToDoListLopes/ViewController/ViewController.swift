//
//  ViewController.swift
//  ToDoListLopes
//
//  Created by user226225 on 1/4/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate  {
    
    var toDoList: [ToDo] = []
    var filteredToDoList: [ToDo]!
    var titre: String = "ToDoList"
    var erreur = false
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredToDoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ToDoTableViewCell
        cell.textLabel?.text = self.filteredToDoList[indexPath.row].nom
        cell.switchToDo.isOn = self.filteredToDoList[indexPath.row].statut
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.filteredToDoList = self.toDoList
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        titreLabel.text = titre
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.filteredToDoList = self.toDoList
        }
        else{
            self.filteredToDoList = toDoList.filter { (object) -> Bool in
                return object.nom.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
       }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DescViewController{
            let row = tableView.indexPathForSelectedRow!.row
            vc.data = toDoList[row]
        }
    }
    
    
    @IBAction func cancel(_ unwindSegue: UIStoryboardSegue) {
        if let vc = unwindSegue.source as? AddViewController{
            vc.dismiss(animated: true)
            
        }
    }
    
    @IBAction func save(_ unwindSegue: UIStoryboardSegue) {
        if let vc = unwindSegue.source as? AddViewController{
            if let toDo = vc.data{
                let i = toDoList.firstIndex{$0.nom ==  toDo.nom}
                if(i == nil){
                    if(toDo.nom != "" && toDo.desc != ""){
                        toDoList.append(toDo)
                    }
                    else{
                        erreur = true
                    }
                }
                else{
                    erreur = true
                }
            }
        }
    }
    
    @IBAction func trash(_ unwindSegue: UIStoryboardSegue) {
        if let vc = unwindSegue.source as? DescViewController{
            if let toDo = vc.data{
                let i = toDoList.firstIndex{$0.nom ==  toDo.nom}
                if(i != nil){
                    toDoList.remove(at: i!)
                
                }

            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.filteredToDoList = self.toDoList
        searchBar.text = "";
        tableView.reloadData()
        if(erreur){
            erreur = false
            self.showAlert(message: "Tache incorrecte : votre tache ne doit pas avoir le même nom que les autres taches et tous les champs doivent être complété.")
        }
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "ERROR", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func sortToDo(_ sender: Any) {
        self.toDoList = self.toDoList.sorted(by: { $0.duTo < $1.duTo })
        self.filteredToDoList = self.filteredToDoList.sorted(by: { $0.duTo < $1.duTo })
        tableView.reloadData()
    }
    
    @IBAction func changeValue(_ sender: Any) {
        guard let switchCell = sender as? UISwitch else { return }
        //On récupere la cellule qui contient le switch qui à changé de valeur
        guard let cell = switchCell.superview?.superview as? UITableViewCell else { return }
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        self.toDoList[indexPath.row].statut = switchCell.isOn
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var titreLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
}

