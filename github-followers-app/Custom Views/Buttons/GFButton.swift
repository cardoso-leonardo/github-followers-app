//
//  GFButton.swift
//  github-followers-app
//
//  Created by Leonardo Cardoso on 11/01/24.
//

import UIKit

class GFButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(color: UIColor, title: String, systemImageName: String, imagePlacement: NSDirectionalRectEdge) {
        self.init(frame: .zero)
        set(color: color, title: title, systemImageName: systemImageName, imagePlacement: imagePlacement)
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        configuration = .tinted()
        configuration?.cornerStyle = .medium
    }
    
    
    final func set(color: UIColor, title: String, systemImageName: String, imagePlacement: NSDirectionalRectEdge) {
        configuration?.baseBackgroundColor = color
        configuration?.baseForegroundColor = color
        configuration?.title = title
        
        configuration?.image = UIImage(systemName: systemImageName)
        configuration?.imagePadding = 6
        configuration?.imagePlacement = imagePlacement
    }
    
}
