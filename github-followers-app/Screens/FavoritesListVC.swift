//
//  FavoritesListVC.swift
//  github-followers-app
//
//  Created by Leonardo Cardoso on 10/01/24.
//

import UIKit

final class FavoritesListVC: GFDataLoadingVC {
    
    private let tableView               = UITableView()
    private var favorites: [Follower]   = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFavorites()
    }
    
    
    override func updateContentUnavailableConfiguration(using state: UIContentUnavailableConfigurationState) {
        if favorites.isEmpty {
            var config = UIContentUnavailableConfiguration.empty()
            config.image = .init(systemName: "star")
            config.text = "No favorites added"
            config.secondaryText = "Add a favorite in followers list"
            
            contentUnavailableConfiguration = config
        } else {
            contentUnavailableConfiguration = nil
        }
        
    }
    
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.frame         = view.bounds
        tableView.delegate      = self
        tableView.dataSource    = self
        tableView.rowHeight     = 80
        tableView.removeExcessCells()
        
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
    }
    
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    private func fetchFavorites() {
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let favorites):
                self.showFavorites(with: favorites)
            case .failure(let error):
                self.presentAlertVC(title: "Oops", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
    private func showFavorites(with favorites: [Follower]) {
        self.favorites = favorites
        setNeedsUpdateContentUnavailableConfiguration()
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.view.bringSubviewToFront(self.tableView)
        }
        
    }

}


extension FavoritesListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID) as! FavoriteCell
        cell.set(favorite: favorites[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite    = favorites[indexPath.row]
        let destVC      = FollowerListVC(username: favorite.login)
        navigationController?.pushViewController(destVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        PersistenceManager.updateWith(favorite: favorites[indexPath.row], actionType: .remove) { [weak self] error in
            guard let self else { return }
            guard let error else {
                favorites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                setNeedsUpdateContentUnavailableConfiguration()
                return
            }
            self.presentAlertVC(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
        }
    }
    
}
