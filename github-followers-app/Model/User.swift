//
//  User.swift
//  github-followers-app
//
//  Created by Leonardo Cardoso on 15/01/24.
//

import Foundation

struct User: Codable {
    let login: String
    let avatarUrl: String
    let htmlUrl: String
    var bio: String?
    var location: String?
    var name: String?
    let createdAt: String
    let publicRepos: Int
    let publicGists: Int
    let followers: Int
    let following: Int
}
