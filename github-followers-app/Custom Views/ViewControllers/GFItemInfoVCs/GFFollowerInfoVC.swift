//
//  GFFollowerInfoVC.swift
//  github-followers-app
//
//  Created by Leonardo Cardoso on 30/01/24.
//

import UIKit

class GFFollowerInfoVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        itemInfoOne.set(type: .followers, with: user.followers)
        itemInfoTwo.set(type: .following, with: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get followers")
    }
    
}
