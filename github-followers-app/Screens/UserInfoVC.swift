//
//  UserInfoVC.swift
//  github-followers-app
//
//  Created by Leonardo Cardoso on 27/01/24.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject {
    func didTapGithubPageButton(with user: User)
    func didTapGetFollowersButton(for user: User)
}

final class UserInfoVC: GFDataLoadingVC {
    
    var username: String!
    weak var delegate: FollowerListVCDelegate?
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    
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
                DispatchQueue.main.async { self.configureUIElements(with: user) }
            case .failure(_):
                break
            }
        }
    }
    
    
    private func configureUIElements(with user: User) {
        
        let repoInfoVC = GFRepoInfoVC(user: user)
        repoInfoVC.delegate = self
        
        let followerInfoVC = GFFollowerInfoVC(user: user)
        followerInfoVC.delegate = self
        
        self.add(childVC: repoInfoVC, to: self.itemViewOne)
        self.add(childVC: followerInfoVC, to: self.itemViewTwo)
        self.add(childVC: GFUserHeaderInfoVC(user: user), to: self.headerView)
        self.dateLabel.text = "Github since \(user.createdAt.convertToDisplayFormat())"
    }
    
    
    private func layoutUI() {
        
        let padding: CGFloat = 20
        let itemViewHeight: CGFloat = 140
        
        viewList = [headerView, itemViewOne, itemViewTwo, dateLabel]
        
        for item in viewList {
            view.addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                item.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                item.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 200),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemViewHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemViewHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }

    
    @objc private func dismissModal() {
        dismiss(animated: true)
    }
    
}


extension UserInfoVC: UserInfoVCDelegate {
    
    func didTapGithubPageButton(with user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentAlertOnMainThread(title: "Invalid URL", message: "This user does not have a valid URL.", buttonTitle: "Ok")
            return
        }
        presentSafariVC(with: url)
    }
    
    
    func didTapGetFollowersButton(for user: User) {
        guard user.followers != 0 else {
            presentAlertOnMainThread(title: "Sad news", message: "This user has no followers at all 😞. You should be the first", buttonTitle: "So sad")
            return
        }
        delegate?.didTapGetFollowersButton(for: user.login)
        dismissModal()
    }
    
}
