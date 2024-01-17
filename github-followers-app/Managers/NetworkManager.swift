//
//  NetworkManage.swift
//  github-followers-app
//
//  Created by Leonardo Cardoso on 16/01/24.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    let baseURL: String = "https://api.github.com/users/"
    let per_page: Int = 100
    
    func fetchFollowers(username: String, page: Int, onCompletion: @escaping ([Follower]?, String?) -> Void) {
        let endpoint = baseURL + "\(username)/followers?per_page=\(per_page)&page=\(page)"
        print(endpoint)
        
        guard let url = URL(string: endpoint) else {
            onCompletion(nil, "Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                onCompletion(nil, "Please check your internet.")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                onCompletion(nil, "Username not found, please try again.")
                return
            }
            
            guard let data = data else {
                onCompletion(nil, "No data was found, please try again.")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                onCompletion(followers, nil)
            } catch {
                onCompletion(nil, "Something went wrong with the data, please try again.")
            }
            
            
        }
        
        task.resume()
        
    }
    
}
