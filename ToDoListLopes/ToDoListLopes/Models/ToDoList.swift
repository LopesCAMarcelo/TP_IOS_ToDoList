//
//  ToDoList.swift
//  ToDoListLopes
//
//  Created by user226225 on 1/8/23.
//

import Foundation

class ToDoList{
    public var nom : String;
    public var toDoList: [ToDo]
    
    init (nom: String) {
        self.nom = nom
        self.toDoList = []
    }
}
