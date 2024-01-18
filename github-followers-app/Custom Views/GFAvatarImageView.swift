//
//  GFAvatarImageView.swift
//  github-followers-app
//
//  Created by Leonardo Cardoso on 18/01/24.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let placeholderImage = UIImage(named: "avatar-placeholder")
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        layer.cornerRadius = 16
        clipsToBounds = true
    }
    
}
