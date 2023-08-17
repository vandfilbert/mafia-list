//
//  ListGameViewModel.swift
//  MafiaList
//
//  Created by Phincon on 8/14/23.
//

import Foundation

class ListGameViewModel: ObservableObject {
    
    private let listGameData: GameListProtocol
    @Published var listGameResult: ListGameModel = ListGameModel([:])
    
    init(_ listGameData: GameListProtocol = GameListData()) {
        self.listGameData = listGameData
    }
    
    func getGameList(search: String = "") {
        
        listGameResult = ListGameModel([:])
        listGameData.fetchGameList(search: search) { [weak self] resultData in
            
            guard let `self` = self else { return }
            switch resultData {
            case .success(let data):
                DispatchQueue.main.async {
                    self.listGameResult = data ?? ListGameModel([:])
                }
            case .error(let err):
                print("\(err.localizedDescription)")
                break
            }
            
        }
        
    }
    
}
