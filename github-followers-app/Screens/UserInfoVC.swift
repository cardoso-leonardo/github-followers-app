//
//  UserInfoVC.swift
//  github-followers-app
//
//  Created by Leonardo Cardoso on 27/01/24.
//

import UIKit

class UserInfoVC: UIViewController {
    
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissModal))
        navigationItem.rightBarButtonItem = doneButton
        navigationItem.title = username!
        
        NetworkManager.shared.fetchUserData(username: username!) { result in
            switch result {
            case .success(let user):
                print(user)
            case .failure(_):
                break
            }
        }
    }

    
    @objc private func dismissModal() {
        dismiss(animated: true)
    }
    
}
