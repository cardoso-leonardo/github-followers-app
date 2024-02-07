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
    
    
    func fetchUserData(username: String, onCompletion: @escaping (Result<User, GFError>) -> Void) {
        let endpoint = baseURL + "\(username)"
        
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
                
                let user = try decoder.decode(User.self, from: data)
                onCompletion(.success(user))
            } catch {
                onCompletion(.failure(.invalidData))
            }
            
        }
        task.resume()
        
    }
    
    
    func downloadImage(url urlString: String, onCompletion: @escaping (UIImage?) -> Void) {
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            onCompletion(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            onCompletion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                    onCompletion(nil)
                    return
                }
            
            self.cache.setObject(image, forKey: cacheKey)
            onCompletion(image)
        }
        task.resume()
    }

    
}
