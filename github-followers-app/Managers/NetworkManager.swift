//
//  NetworkManage.swift
//  github-followers-app
//
//  Created by Leonardo Cardoso on 16/01/24.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    private let baseURL: String = "https://api.github.com/users/"
    private let per_page: Int = 100
    
    func fetchFollowers(username: String, page: Int, onCompletion: @escaping (Result<[Follower], GFError>) -> Void) {
        let endpoint = baseURL + "\(username)/followers?per_page=\(per_page)&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            onCompletion(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                onCompletion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                onCompletion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                onCompletion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                onCompletion(.success(followers))
            } catch {
                onCompletion(.failure(.invalidData))
            }
            
            
        }
        
        task.resume()
        
    }
    
}
