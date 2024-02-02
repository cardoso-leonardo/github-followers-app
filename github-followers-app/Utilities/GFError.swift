//
//  File.swift
//  github-followers-app
//
//  Created by Leonardo Cardoso on 17/01/24.
//

import Foundation

enum GFError: String, Error {
    
    //MARK: NetworkManager
    case invalidUsername = "This username created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
    
    //MARK: PersistenceManager
    case unableToRetrieveFavorites = "Unable to retrieve favorites. Please try again later."
    case unableToSaveFavorites = "Unable to save favorites."
    case alreadyMarkedAsFavorite = "This user has already been marked as favorites."
}

