//
//  Date+Ext.swift
//  github-followers-app
//
//  Created by Leonardo Cardoso on 31/01/24.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
    
}
