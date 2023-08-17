//
//  DetailGameViewController.swift
//  MafiaList
//
//  Created by Phincon on 8/16/23.
//

import Foundation

class DetailGameViewModel: ObservableObject {
    
    private let listGameData: GameListProtocol
    @Published var detailGame: DetailGameModel = DetailGameModel([:])
    
    init(_ listGameData: GameListProtocol = GameListData()) {
        self.listGameData = listGameData
    }
    
    func getDetailGame(idGame: Int) {
        
        listGameData.getDetailGame(idGame: idGame) { [weak self] detailResult in
            
            guard let `self` = self else { return }
            switch detailResult {
            case .success(let data):
                DispatchQueue.main.async {
                    self.detailGame = data ?? DetailGameModel([:])
                }
            case .error(let err):
                print("\(err.localizedDescription)")
                break
            }
            
        }
        
    }
    
    func saveGameToFavorite(game: DetailGameModel) {
        
        let gameSaved = FavoriteGame(context: PersistenceController.shared.viewContext)
        gameSaved.idGame = String(game.id)
        gameSaved.nameGame = game.nameOriginal
        gameSaved.imageGame = game.backgroundImage
        gameSaved.descriptionGame = game.description
        gameSaved.ratingGame = String(format: "%.2f", game.rating)
        gameSaved.releasedGame = game.released
        PersistenceController.shared.save()
        
    }
    
    func deleteFavorite() {
        
        if let deleteDataFavorite = PersistenceController.shared.getFavoriteById(idGame: String(detailGame.id)) {
            do {
                try PersistenceController.shared.deleteFavorite(deleteDataFavorite)
            }catch {
                print(error.localizedDescription)
            }
        }
    
    }
    
    func checkDataFavorite(idGame: String) -> Bool {
        
        for fav in PersistenceController.shared.getAllFavoriteGames() {
            
            if fav.idGame == idGame {
                return true
            }
            
        }
        return false
        
    }
    
}
