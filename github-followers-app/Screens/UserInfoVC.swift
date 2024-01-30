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
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    
    var viewList: [UIView] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layoutUI()
        fetchUser()
        
    }
    
    
    private func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissModal))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    
    private func fetchUser() {
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
    }
    
    
    private func layoutUI() {
        
        let padding: CGFloat = 20
        let itemViewHeight: CGFloat = 140
        
        viewList = [headerView, itemViewOne, itemViewTwo]
        
        for item in viewList {
            view.addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                item.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                item.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            ])
        }
        
        itemViewOne.backgroundColor = .systemBlue
        itemViewTwo.backgroundColor = .systemRed
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemViewHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemViewHeight)
        ])
    }

    
    @objc private func dismissModal() {
        dismiss(animated: true)
    }
    
}
