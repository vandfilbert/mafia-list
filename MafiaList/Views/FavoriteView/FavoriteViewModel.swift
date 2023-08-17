//
//  FavoriteViewModel.swift
//  MafiaList
//
//  Created by Phincon on 8/17/23.
//

import Foundation

class FavoriteViewModel: ObservableObject {
    
    @Published var resultGamesFavorite = [FavoriteGame]()
    
    func getFavoriteGames() {
    
        resultGamesFavorite = []
        for fav in PersistenceController.shared.getAllFavoriteGames() {
            resultGamesFavorite.append(fav)
        }
        
    }
    
    func getFavoriteGameByName(nameGame: String) {
        
        resultGamesFavorite = []
        for fav in PersistenceController.shared.getFavoriteByName(nameGame: nameGame) {
            resultGamesFavorite.append(fav)
        }
        
    }
    
}
