//
//  FavoriteCell.swift
//  github-followers-app
//
//  Created by Leonardo Cardoso on 03/02/24.
//

import UIKit

class FavoriteCell: UITableViewCell {

    static let reuseID      = "FavoriteCell"
    
    private let avatarImage = GFAvatarImageView(frame: .zero)
    private let username    = GFTitleLabel(textAlignment: .left, fontSize: 26)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(favorite: Follower) {
        username.text = favorite.login
        avatarImage.downloadImage(fromURL: favorite.avatarUrl)
    }
    
    
    private func configure() {
        addSubviews(views: avatarImage, username)
        accessoryType = .disclosureIndicator
        
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            avatarImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImage.widthAnchor.constraint(equalToConstant: 60),
            avatarImage.heightAnchor.constraint(equalToConstant: 60),
            
            username.centerYAnchor.constraint(equalTo: centerYAnchor),
            username.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 24),
            username.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            username.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

}
