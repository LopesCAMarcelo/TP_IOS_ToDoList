//
//  ToDo.swift
//  ToDoListLopes
//
//  Created by user226225 on 1/4/23.
//

import Foundation

class ToDo{
    public var desc: String;
    public var nom : String;
    public var statut: Bool
    public var duTo: Date
    
    init (nom: String, desc: String,date:String) {
        self.desc = desc
        self.nom = nom
        self.statut = false
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let date = dateFormatter.date(from: date)
        if(date == nil){
            print("le format de date est dd/MM/yyyy")
            self.duTo = Date.now
        }
        else{
            self.duTo = date!
        }
    }
    
    
    init(){
        self.nom = ""
        self.desc = ""
        self.statut = false
        self.duTo = Date.now
    }
}
