//
//  GFRepoInfoVC.swift
//  github-followers-app
//
//  Created by Leonardo Cardoso on 30/01/24.
//

import UIKit

protocol GFRepoInfoVCDelegate: AnyObject {
    func didTapGithubPageButton(with user: User)
}

final class GFRepoInfoVC: GFItemInfoVC {
    
    weak var delegate: GFRepoInfoVCDelegate?
    
    
    init(user: User, delegate: GFRepoInfoVCDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
    private func configure() {
        itemInfoOne.set(type: .repos, with: user.publicRepos)
        itemInfoTwo.set(type: .gists, with: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "Github page")
    }
    
    
    override func actionButtonTapped() {
        delegate?.didTapGithubPageButton(with: user)
    }
    
}
