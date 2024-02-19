//
//  Date+Ext.swift
//  github-followers-app
//
//  Created by Leonardo Cardoso on 31/01/24.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        return formatted(.dateTime.month().year())
    }
    
}
