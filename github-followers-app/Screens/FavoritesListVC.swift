//
//  FavoritesListVC.swift
//  github-followers-app
//
//  Created by Leonardo Cardoso on 10/01/24.
//

import UIKit

class FavoritesListVC: UIViewController {
    
    private var tableView: UITableView!
    
    private var favorites: [Follower] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        fetchFavorites()
        configureTableView()
        layoutUI()
    }
    
    
    
    private func configureTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
    }
    
    
    private func layoutUI() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    private func fetchFavorites() {
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let favorites):
                self.favorites = favorites
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Oops", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }

}


extension FavoritesListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FavoriteCell(style: .default, reuseIdentifier: FavoriteCell.reuseID)
        cell.set(favorite: favorites[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userVC = UserInfoVC()
        userVC.username = favorites[indexPath.row].login
        self.present(userVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
