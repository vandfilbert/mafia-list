//
//  ApiServiceExt.swift
//  MafiaList
//
//  Created by Phincon on 8/14/23.
//

import Foundation

protocol GameProtocol {
    func getListGames(search: String, completion: @escaping (ListGameModel?, Error?) -> Void)
    func getDetailGame(idGame: Int, completion: @escaping (DetailGameModel?, Error?) -> Void)
}

class ApiServiceExt: GameProtocol {
    
    func getListGames(search: String, completion: @escaping (ListGameModel?, Error?) -> Void) {
        
        var urlQuery = ""
        if search.isEmpty {
            urlQuery = "\(Constanta.endPoint)\(Constanta.getListGame)?\(Constanta.apiKey)"
        } else {
            if let encodedQuery = search.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                urlQuery = "\(Constanta.endPoint)\(Constanta.getListGame)?search=\(encodedQuery)&\(Constanta.apiKey)"
            }
        }
        
        guard let url = URL(string: urlQuery) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                if let result = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    let listGameModel = ListGameModel(result)
                    completion(listGameModel, nil)
                }
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
                completion(nil, error)
            }
        }.resume()
        
    }
    
    func getDetailGame(idGame: Int, completion: @escaping (DetailGameModel?, Error?) -> Void) {
        
        guard let url = URL(string: "\(Constanta.endPoint)\(Constanta.getListGame)/\(idGame)?\(Constanta.apiKey)") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                if let result = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    let detailGameModel = DetailGameModel(result)
                    completion(detailGameModel, nil)
                }
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
                completion(nil, error)
            }
        }.resume()
        
    }
    
}
