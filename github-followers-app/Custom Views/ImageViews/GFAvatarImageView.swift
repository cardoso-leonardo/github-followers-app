//
//  GFAvatarImageView.swift
//  github-followers-app
//
//  Created by Leonardo Cardoso on 18/01/24.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let placeholderImage    = Images.placeholder
    let cache               = NetworkManager.shared.cache
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius  = 16
        clipsToBounds       = true
        image               = placeholderImage
    }
    
    
    func downloadImage(fromURL url: String) {
        NetworkManager.shared.downloadImage(url: url) { [weak self] image in
            guard let self = self else {return }
            DispatchQueue.main.async { self.image = image }
        }
    }
    
}
