//
//  GFFollowerInfoVC.swift
//  github-followers-app
//
//  Created by Leonardo Cardoso on 30/01/24.
//

import UIKit

protocol GFFollowerInfoVCDelegate: AnyObject {
    func didTapGetFollowersButton(for user: User)
}

final class GFFollowerInfoVC: GFItemInfoVC {
    
    weak var delegate: GFFollowerInfoVCDelegate?
    
    
    init(user: User, delegate: GFFollowerInfoVCDelegate) {
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
        itemInfoOne.set(type: .followers, with: user.followers)
        itemInfoTwo.set(type: .following, with: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get followers")
    }
    
    
    override func actionButtonTapped() {
        delegate?.didTapGetFollowersButton(for: user)
    }
    
}
