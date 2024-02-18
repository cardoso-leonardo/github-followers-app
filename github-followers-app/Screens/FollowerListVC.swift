//
//  FollowerListVC.swift
//  github-followers-app
//
//  Created by Leonardo Cardoso on 13/01/24.
//

import UIKit

final class FollowerListVC: GFDataLoadingVC {

    enum Section { case main }
    
    private var username: String!
    private var followers: [Follower]           = []
    private var filteredFollowers: [Follower]   = []
    
    private var page: Int               = 1
    private var hasMoreFollowers: Bool  = true
    private var isSearching: Bool       = false
    private var isLoadingMoreData: Bool = false
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        configureSearchController()
        getFollowers(username: username, page: page)
        configureDiffableDataSource()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
        title = username
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        let addButton = UIBarButtonItem(image: SFSymbols.heart, style: .plain, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    
    private func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for a username"
        navigationItem.searchController = searchController
    }
    
    
    private func getFollowers(username: String, page: Int) {
        showLoadingView()
        isLoadingMoreData = true
        
        Task {
            do {
                let followers = try await NetworkManager.shared.fetchFollowers(username: username, page: page)
                updateUI(with: followers)
                dismissLoadingView()
                isLoadingMoreData = false
            } catch {
                if let gfError = error as? GFError {
                    presentAlertVC(title: "Ooops", message: gfError.rawValue, buttonTitle: "Ok")
                } else {
                    presentDefaultAlert()
                }
                dismissLoadingView()
            }
        }
    }
    
    
    private func configureDiffableDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: itemIdentifier)
            return cell
        })
    }
    
    
    private func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
    
    
    @objc func addButtonTapped() {
        showLoadingView()
        Task {
            do {
                let user = try await NetworkManager.shared.fetchUserData(username: username)
                addToFavorite(with: user)
                dismissLoadingView()
            } catch {
                if let gfError = error as? GFError {
                    presentAlertVC(title: "Something went wrong", message: gfError.rawValue, buttonTitle: "Ok")
                } else {
                    presentDefaultAlert()
                }
                dismissLoadingView()
            }
        }
    }
    
    
    private func addToFavorite(with user: User) {
        let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
        
        PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else {
                presentAlertVC(title: "Success!", message: "This user is now marked as favorite 🎉.", buttonTitle: "Hooray!")
                return
            }
            presentAlertVC(title: "Ooops", message: error.rawValue, buttonTitle: "Ok")
        }
    }
    
    
    private func updateUI(with followers: [Follower]) {
        if followers.count < 100 { self.hasMoreFollowers = false }
        self.followers.append(contentsOf: followers)
        
        if self.followers.isEmpty {
            let message = "This user doesn't have any followers 😔."
            DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view) }
            return
        }
        self.updateData(on: self.followers)
    }
    
}


extension FollowerListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = collectionView.contentOffset.y
        let contentHeight   = collectionView.contentSize.height
        let height          = collectionView.frame.size.height
        
        if offsetY > (contentHeight - height) {
            guard hasMoreFollowers, !isLoadingMoreData else {return}
            page += 1
            getFollowers(username: username, page: page)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredFollowers : followers
        let follower    = activeArray[indexPath.item]
        let destVC      = UserInfoVC()
        
        destVC.username = follower.login
        destVC.delegate = self
        
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
    
}


extension FollowerListVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredFollowers.removeAll()
            updateData(on: followers)
            isSearching = false
            return
        }
        isSearching = true
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredFollowers)
    }
    
}


extension FollowerListVC: UserInfoVCDelegate {
    
    func didTapGetFollowersButton(for username: String) {
        self.username   = username
        self.title      = username
        page            = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        getFollowers(username: username, page: page)
    }
    
}
