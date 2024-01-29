//
//  GFUserHeaderInfoVC.swift
//  github-followers-app
//
//  Created by Leonardo Cardoso on 29/01/24.
//

import UIKit

class GFUserHeaderInfoVC: UIViewController {
    
    private var avatarImageView = GFAvatarImageView(frame: .zero)
    private var usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 38)
    private var secondaryLabel = GFMediumLabel(fontSize: 28)
    private var locationImage = UIImageView()
    private var locationLabel = GFMediumLabel(fontSize: 28)
    private var bioLabel = GFBodyLabel(textAlignment: .left)
    
    private var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func configureUI() {
        
    }
    
    
    private func layoutUI() {
        view.addSubviews(views:avatarImageView, usernameLabel, secondaryLabel, locationImage, locationLabel, bioLabel)
        locationImage.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    
    
}
