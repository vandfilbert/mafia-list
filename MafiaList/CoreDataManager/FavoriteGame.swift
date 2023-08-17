//
//  FavoriteGames.swift
//  MafiaList
//
//  Created by Phincon on 8/16/23.
//

import Foundation
import CoreData
import UIKit

@objc(FavoriteGame)
class FavoriteGame : NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteGame> {
        return NSFetchRequest<FavoriteGame>(entityName: "FavoriteGame")
    }

    @NSManaged public var idGame: String?
    @NSManaged public var nameGame: String?
    @NSManaged public var imageGame: String?
    @NSManaged public var ratingGame: String?
    @NSManaged public var releasedGame: String?
    @NSManaged public var descriptionGame: String?

}

extension FavoriteGame : Identifiable {

}
