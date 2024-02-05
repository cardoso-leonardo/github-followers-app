//
//  FavoritesListVC.swift
//  github-followers-app
//
//  Created by Leonardo Cardoso on 10/01/24.
//

import UIKit

class FavoritesListVC: UIViewController {
    
    private var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        
        
    }
    
    
    
    private func configureTableView() {
        
    }
    
    
    private func configure() {
        
    }
    
    
    private func fetchFavorites() {
        PersistenceManager.retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                print(favorites)
            case .failure(let error):
                break
            }
        }
    }

}
