//
//  UIVIewController+Ext.swift
//  github-followers-app
//
//  Created by Leonardo Cardoso on 14/01/24.
//

import UIKit
import SafariServices

extension UIViewController {
    
    func presentAlertVC(title: String, message: String, buttonTitle: String) {
        let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
        alertVC.modalTransitionStyle = .crossDissolve
        alertVC.modalPresentationStyle = .overFullScreen
        self.present(alertVC, animated: true)
    }
    
    
    func presentDefaultAlert() {
        let alertVC = GFAlertVC(title: "Something went wrong", message: "Unable to complete task, please try again later", buttonTitle: "Ok")
        alertVC.modalTransitionStyle = .crossDissolve
        alertVC.modalPresentationStyle = .overFullScreen
        self.present(alertVC, animated: true)
    }
    
    
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
    
}
