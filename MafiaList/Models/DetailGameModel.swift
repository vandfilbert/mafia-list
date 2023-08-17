//
//  DetailGameModel.swift
//  MafiaList
//
//  Created by Phincon on 8/16/23.
//

import Foundation

struct DetailGameModel: Identifiable, Equatable {
    
    let id: Int
    let nameOriginal: String
    let description: String
    let released: String
    let rating: Double
    let backgroundImage: String
    
    init (_ dict: [String: Any]) {
        
        self.id = dict["id"] as? Int ?? 0
        self.nameOriginal = dict["name_original"] as? String ?? ""
        self.description = dict["description"] as? String ?? ""
        self.released = dict["released"] as? String ?? ""
        self.rating = dict["rating"] as? Double ?? 0.0
        self.backgroundImage = dict["background_image"] as? String ?? ""
        
    }
    
}
