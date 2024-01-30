//
//  GFUserHeaderInfoVC.swift
//  github-followers-app
//
//  Created by Leonardo Cardoso on 29/01/24.
//

import UIKit

class GFUserHeaderInfoVC: UIViewController {
    
    private var avatarImageView = GFAvatarImageView(frame: .zero)
    private var usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 34)
    private var nameLabel = GFMediumLabel(fontSize: 18)
    private var locationImage = UIImageView()
    private var locationLabel = GFMediumLabel(fontSize: 18)
    private var bioLabel = GFBodyLabel(textAlignment: .left)
    
    private var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        configureUI()
        
    }
    
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func configureUI() {
        avatarImageView.downloadImage(url: user.avatarUrl)
        usernameLabel.text = user.login
        nameLabel.text = user.name ?? ""
        locationImage.image = UIImage(systemName: SFSymbols.location)
        locationImage.tintColor = .label
        locationLabel.text = user.location ?? "Location not found"
        
        bioLabel.text = user.bio ?? "No bio"
        bioLabel.numberOfLines = 3
    }
    
    
    private func layoutUI() {
        view.addSubviews(views:avatarImageView, usernameLabel, nameLabel, locationImage, locationLabel, bioLabel)
        locationImage.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 20
        let textImagePadding: CGFloat = 12
        
        NSLayoutConstraint.activate([
        
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            locationImage.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImage.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            locationImage.widthAnchor.constraint(equalToConstant: 20),
            locationImage.heightAnchor.constraint(equalToConstant: 20),
            
            locationLabel.centerYAnchor.constraint(equalTo: locationImage.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImage.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textImagePadding),
            bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bioLabel.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    
}
