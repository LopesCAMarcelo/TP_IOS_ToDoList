//
//  CategoryViewController.swift
//  ToDoListLopes
//
//  Created by user226225 on 1/8/23.
//

import UIKit

class CategoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate   {

    var categorytoDoList: [ToDoList] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categorytoDoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = categoryTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CategoryTableViewCell
        
        cell.LabelName.text = self.categorytoDoList[indexPath.row].nom
        return cell
    }
    
    @IBAction func addCategory(_ sender: Any) {
        let alert = UIAlertController(title: "Créer une nouvelle catégorie", message: "Entrez le nom de votre nouvelle catégorie", preferredStyle: .alert)
        alert.addTextField(){(text) in
            text.isEnabled = true
        }
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            let newValue = alert.textFields![0].text
            let i = self.categorytoDoList.firstIndex{$0.nom ==  newValue}
            if(i == nil){
                if(newValue != ""){
                    self.categorytoDoList.append(ToDoList(nom: newValue!))
                    self.categoryTableView.reloadData()
                }
            }
            else{
                        
            }
        }
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    
    @IBAction func backCategory(_ unwindSegue: UIStoryboardSegue) {
        if let vc = unwindSegue.source as? ViewController{
            let toDoList = vc.toDoList
            let i = categorytoDoList.firstIndex{$0.nom ==  vc.titre}
            if(i != nil){
                self.categorytoDoList[i!].toDoList = toDoList
            }
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Exemple de tache pour manipuler l'application
        let toDo1 = ToDo(nom: "Faire les courses", desc: "lait,riz...",date:"01/01/2085")
        let toDo2 = ToDo(nom: "Aller a la salle de sport", desc: "ne pas oublier sa serviette",date:"12/12/2020")
        let toDo3 = ToDo(nom: "Rendre les clés a Jackie", desc: "le faire le plus tot possible",date:"05/04/2021")
        let category1 = ToDoList(nom: "Perso")
        category1.toDoList.append(toDo1)
        category1.toDoList.append(toDo2)
        category1.toDoList.append(toDo3)
        self.categorytoDoList.append(category1)
        
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ViewController{
            let row = categoryTableView.indexPathForSelectedRow!.row
            vc.toDoList = categorytoDoList[row].toDoList
            vc.titre = categorytoDoList[row].nom
        }
    }
    
    @IBAction func trashCategory(_ unwindSegue: UIStoryboardSegue) {
        if let vc = unwindSegue.source as? ViewController{
            let categoryTitle = vc.titre
            let i = categorytoDoList.firstIndex{$0.nom ==  categoryTitle}
            if(i != nil){
                categorytoDoList.remove(at: i!)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.categoryTableView.reloadData()
    }

    

    @IBOutlet weak var categoryTableView: UITableView!
}
