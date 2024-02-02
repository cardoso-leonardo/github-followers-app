//
//  PersistenceManager.swift
//  github-followers-app
//
//  Created by Leonardo Cardoso on 02/02/24.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
        
    enum Keys {
        static let favorites = "favorites"
    }
    
    static let defaults = UserDefaults.standard
    
    
    static func updateWith(favorite: Follower, actionType: PersistenceActionType, onCompletion: @escaping (GFError?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                var retrievedFavorites = favorites
                switch actionType {
                case .add:
                    guard !retrievedFavorites.contains(favorite) else {
                        onCompletion(.alreadyMarkedAsFavorite)
                        return
                    }
                    retrievedFavorites.append(favorite)
                case .remove:
                    retrievedFavorites.removeAll {$0.login == favorite.login}
                }
                
                onCompletion(save(favorites: retrievedFavorites))
            case .failure(let error):
                onCompletion(error)
            }
        }
    }
    
    
    static func retrieveFavorites(onCompletion: @escaping (Result<[Follower], GFError>) -> Void) {
        guard let retrievedData = defaults.object(forKey: Keys.favorites) as? Data else {
            onCompletion(.success([]))
            return
        }
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode([Follower].self, from: retrievedData)
            onCompletion(.success(decodedData))
        } catch {
            onCompletion(.failure(.unableToRetrieveFavorites))
        }
    }
    
    
    static func save(favorites: [Follower]) -> GFError? {
        do {
            let enconder = JSONEncoder()
            let encondedData = try enconder.encode(favorites)
            defaults.set(encondedData, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToSaveFavorites
        }
    }
    
}
