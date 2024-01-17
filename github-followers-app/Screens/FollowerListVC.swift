//
//  FollowerListVC.swift
//  github-followers-app
//
//  Created by Leonardo Cardoso on 13/01/24.
//

import UIKit

class FollowerListVC: UIViewController {

    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        NetworkManager.shared.fetchFollowers(username: username, page: 1) { followers, errorMessage in
            guard let followers = followers else {
                self.presentAlertOnMainThread(title: "Ooops", message: errorMessage!.rawValue, buttonTitle: "Ok")
                return
            }
            print(followers.count)
            print(followers)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}
