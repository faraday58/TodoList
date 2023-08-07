//
//  NoteModel.swift
//  TodoList
//
//  Created by Armando Rodríguez on 07/08/23.
//

import Foundation


struct NoteModel: Codable {
    let id: String
    var description: String
    var isFavorited: Bool
    
    init(id: String = UUID().uuidString, description: String, isFavorited: Bool = false ){
        self.id = id
        self.description = description
        self.isFavorited = isFavorited
        
        
    }
}
