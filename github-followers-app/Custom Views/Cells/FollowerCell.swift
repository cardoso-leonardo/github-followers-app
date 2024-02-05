//
//  FollowerCell.swift
//  github-followers-app
//
//  Created by Leonardo Cardoso on 18/01/24.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    static let reuseID = "FollowerCell"
    
    private let avatarImage = GFAvatarImageView(frame: .zero)
    private let username = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(follower: Follower) {
        username.text = follower.login
        avatarImage.downloadImage(url: follower.avatarUrl)
    }
    
    
    private func configure() {
        addSubviews(views: avatarImage, username)
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            avatarImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            avatarImage.heightAnchor.constraint(equalTo: avatarImage.widthAnchor),
            
            username.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 12),
            username.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            username.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            username.heightAnchor.constraint(equalToConstant: 20)
        
        ])
    }
    
}
