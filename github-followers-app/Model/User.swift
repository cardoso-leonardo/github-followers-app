//
//  User.swift
//  github-followers-app
//
//  Created by Leonardo Cardoso on 15/01/24.
//

import Foundation

struct User: Codable {
    var login: String
    var avatarUrl: String
    var htmlUrl: String
    var bio: String?
    var location: String?
    var name: String?
    var createdAt: String
    var publicRepos: Int
    var publicGists: Int
    var followers: Int
    var following: Int
}
