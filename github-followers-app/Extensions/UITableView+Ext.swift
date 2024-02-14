//
//  UITableView+Ext.swift
//  github-followers-app
//
//  Created by Leonardo Cardoso on 14/02/24.
//

import UIKit

extension UITableView {
    
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
    
}
