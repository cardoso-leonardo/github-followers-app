//
//  FollowerCell.swift
//  github-followers-app
//
//  Created by Leonardo Cardoso on 18/01/24.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    static let reuseID = "FollowerCell"
    
    let avatarImagge = GFAvatarImageView(frame: .zero)
    let username = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        
    }
    
}
