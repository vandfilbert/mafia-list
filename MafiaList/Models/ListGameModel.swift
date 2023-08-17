//
//  ListGameModel.swift
//  MafiaList
//
//  Created by Phincon on 8/14/23.
//

import Foundation

struct ListGameModel: Codable {
    
    let count: Int
    let next: String
    let previous: String
    let results: [Game]
    
    init(_ dict: [String: Any]) {
        count = dict["count"] as? Int ?? 0
        next = dict["next"] as? String ?? ""
        previous = dict["previous"] as? String ?? ""
        results = (dict["results"] as? [[String: Any]] ?? []).compactMap { Game($0) }
    }
    
}

struct Game: Codable, Identifiable {
    
    let id: Int
    let slug: String
    let name: String
    let released: String
    let tba: Bool
    let backgroundImage: String
    let rating: Double
    let ratingTop: Double
    let ratings: [Rating]
    let ratingsCount: Int
    let reviewsTextCount: String
    let added: Int
    let addedByStatus: AddedByStatus
    let metacritic: Int
    let playtime: Int
    let suggestionsCount: Int
    let updated: String
    let esrbRating: ESRBRating
    let platforms: [Platform]
    
    init(_ dict: [String: Any]) {
        id = dict["id"] as? Int ?? 0
        slug = dict["slug"] as? String ?? ""
        name = dict["name"] as? String ?? ""
        released = dict["released"] as? String ?? ""
        tba = dict["tba"] as? Bool ?? false
        backgroundImage = dict["background_image"] as? String ?? ""
        rating = dict["rating"] as? Double ?? 0.0
        ratingTop = dict["rating_top"] as? Double ?? 0.0
        ratings = (dict["ratings"] as? [[String: Any]] ?? []).compactMap { Rating($0) }
        ratingsCount = dict["ratings_count"] as? Int ?? 0
        reviewsTextCount = dict["reviews_text_count"] as? String ?? ""
        added = dict["added"] as? Int ?? 0
        addedByStatus = AddedByStatus(dict["added_by_status"] as? [String: Any] ?? [:])
        metacritic = dict["metacritic"] as? Int ?? 0
        playtime = dict["playtime"] as? Int ?? 0
        suggestionsCount = dict["suggestions_count"] as? Int ?? 0
        updated = dict["updated"] as? String ?? ""
        esrbRating = ESRBRating(dict["esrb_rating"] as? [String: Any] ?? [:])
        platforms = (dict["platforms"] as? [[String: Any]] ?? []).compactMap { Platform($0) }
    }
    
}

struct Rating: Codable {
    
    let id: Int
    let title: String
    let count: Int
    let percent: Double
    
    init(_ dict: [String: Any]) {
        id = dict["id"] as? Int ?? 0
        title = dict["title"] as? String ?? ""
        count = dict["count"] as? Int ?? 0
        percent = dict["percent"] as? Double ?? 0.0
    }
    
}

struct AddedByStatus: Codable {
    
    let yet: Int
    let owned: Int
    let beaten: Int
    let toplay: Int
    let dropped: Int
    let playing: Int
    
    init(_ dict: [String: Any]) {
        yet = dict["yet"] as? Int ?? 0
        owned = dict["owned"] as? Int ?? 0
        beaten = dict["beaten"] as? Int ?? 0
        toplay = dict["toplay"] as? Int ?? 0
        dropped = dict["dropped"] as? Int ?? 0
        playing = dict["playing"] as? Int ?? 0
    }
    
}

struct ESRBRating: Codable {
    
    let id: Int
    let slug: String
    let name: String
    
    init(_ dict: [String: Any]) {
        id = dict["id"] as? Int ?? 0
        slug = dict["slug"] as? String ?? ""
        name = dict["name"] as? String ?? ""
    }
    
}

struct Platform: Codable {
    
    let platform: PlatformInfo
    let releasedAt: String
    let requirements: Requirements
    
    init(_ dict: [String: Any]) {
        platform = PlatformInfo(dict["platform"] as? [String: Any] ?? [:])
        releasedAt = dict["released_at"] as? String ?? ""
        requirements = Requirements(dict["requirements"] as? [String: Any] ?? [:])
    }
    
}

struct PlatformInfo: Codable {
    
    let id: Int
    let slug: String
    let name: String
    
    init(_ dict: [String: Any]) {
        id = dict["id"] as? Int ?? 0
        slug = dict["slug"] as? String ?? ""
        name = dict["name"] as? String ?? ""
    }
    
}

struct Requirements: Codable {
    
    let minimum: String
    let recommended: String
    
    init(_ dict: [String: Any]) {
        minimum = dict["minimum"] as? String ?? ""
        recommended = dict["recommended"] as? String ?? ""
    }
    
}
