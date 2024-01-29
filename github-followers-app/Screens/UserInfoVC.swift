//
//  UserInfoVC.swift
//  github-followers-app
//
//  Created by Leonardo Cardoso on 27/01/24.
//

import UIKit

class UserInfoVC: UIViewController {
    
    var username: String!
    
    let headerView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissModal))
        navigationItem.rightBarButtonItem = doneButton
        
        NetworkManager.shared.fetchUserData(username: username!) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.add(childVC: GFUserHeaderInfoVC(user: user), to: self.headerView)
                }
                
            case .failure(_):
                break
            }
        }
        
        layoutUI()
    }
    
    
    private func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    
    private func layoutUI() {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180)
            
        ])
    }

    
    @objc private func dismissModal() {
        dismiss(animated: true)
    }
    
    
    
}
