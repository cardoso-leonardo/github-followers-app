//
//  UIVIewController+Ext.swift
//  github-followers-app
//
//  Created by Leonardo Cardoso on 14/01/24.
//

import UIKit

extension UIViewController {
    
    func presentAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        
        let alertVC = AlertVC(title: title, message: message, buttonTitle: buttonTitle)
        alertVC.modalTransitionStyle = .crossDissolve
        alertVC.modalPresentationStyle = .overFullScreen
        DispatchQueue.main.async {
            self.present(alertVC, animated: true)
        }
        
    }
    
}
