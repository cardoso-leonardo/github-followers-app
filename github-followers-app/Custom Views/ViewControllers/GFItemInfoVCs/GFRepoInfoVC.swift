//
//  GFRepoInfoVC.swift
//  github-followers-app
//
//  Created by Leonardo Cardoso on 30/01/24.
//

import UIKit

class GFRepoInfoVC: GFItemInfoVC {
    
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
