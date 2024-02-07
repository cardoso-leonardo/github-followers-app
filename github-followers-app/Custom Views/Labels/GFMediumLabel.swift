//
//  GFMediumLabel.swift
//  github-followers-app
//
//  Created by Leonardo Cardoso on 29/01/24.
//

import UIKit

class GFMediumLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }
    
    
    private func configure() {
        lineBreakMode = .byTruncatingTail
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.90
        
        translatesAutoresizingMaskIntoConstraints = false
    }

}
