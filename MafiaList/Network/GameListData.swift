//
//  GameListData.swift
//  MafiaList
//
//  Created by Phincon on 8/14/23.
//

import Foundation

enum GameListResult {
    case success(_ data: ListGameModel?)
    case error(_ data: Error)
}

enum DetailGameResult {
    case success(_ data: DetailGameModel?)
    case error(_ data: Error)
}

protocol GameListProtocol {
    func fetchGameList(search: String, completion: @escaping (GameListResult) -> Void)
    func getDetailGame(idGame: Int, completion: @escaping (DetailGameResult) -> Void)
}

class GameListData: GameListProtocol {

    private let apiService: ApiServiceExt
    
    init(apiService: ApiServiceExt = ApiServiceExt()) {
        self.apiService = apiService
    }
    
    func fetchGameList(search: String, completion: @escaping (GameListResult) -> Void) {
        
        apiService.getListGames(search: search) { resultList, err in
            
            if let err = err {
                completion(.error(err))
            } else {
                completion(.success(resultList))
            }
            
        }
        
    }
    
    func getDetailGame(idGame: Int, completion: @escaping (DetailGameResult) -> Void) {
        
        apiService.getDetailGame(idGame: idGame) { resultDetail, err in
            
            if let err = err {
                completion(.error(err))
            } else {
                completion(.success(resultDetail))
            }
            
        }
        
    }
    
}
