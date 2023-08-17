//
//  PersistenceController.swift
//  MafiaList
//
//  Created by Phincon on 8/16/23.
//

import Foundation
import CoreData
import CloudKit

struct PersistenceController {
    
    static let shared = PersistenceController()
    let container: NSPersistentCloudKitContainer
    var viewContext: NSManagedObjectContext {
        container.viewContext
    }
    
    init(inMemory: Bool = false) {
        
        container = NSPersistentCloudKitContainer(name: "FavoriteGameModel")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError(error.localizedDescription)
            }
        }
        
    }
    
    public func save() {
        
        if viewContext.hasChanges {
            
            do {
                try viewContext.save()
            } catch {
                viewContext.rollback()
                print(error.localizedDescription)
            }

        }
        
    }
    
    public func getAllFavoriteGames() -> [FavoriteGame] {
        
        let request: NSFetchRequest<FavoriteGame> = FavoriteGame.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "idGame", ascending: true)]
        do {
            return try viewContext.fetch(request)
        }catch {
            print(error.localizedDescription)
            return []
        }
        
    }
    
    public func getFavoriteById(idGame: String) -> FavoriteGame? {
        
        let request: NSFetchRequest<FavoriteGame> = FavoriteGame.fetchRequest()
        request.predicate = NSPredicate(format: "idGame LIKE %@", idGame)
        request.sortDescriptors = [NSSortDescriptor(key: "idGame", ascending: true)]
        do {
            return try viewContext.fetch(request).first
        }catch {
            print(error.localizedDescription)
            return nil
        }
        
    }
    
    public func getFavoriteByName(nameGame: String) -> [FavoriteGame] {
        
        let request: NSFetchRequest<FavoriteGame> = FavoriteGame.fetchRequest()
        request.predicate = NSPredicate(format: "nameGame BEGINSWITH[cd] %@", nameGame)
        request.sortDescriptors = [NSSortDescriptor(key: "idGame", ascending: true)]
        do {
            return try viewContext.fetch(request)
        }catch {
            print(error.localizedDescription)
            return []
        }
        
    }
    
    public func deleteFavorite(_ game: FavoriteGame) throws {
        viewContext.delete(game)
        save()
    }
    
}
