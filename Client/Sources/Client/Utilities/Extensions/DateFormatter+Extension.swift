//
//  File.swift
//  
//
//  Created by Fabrício Sperotto Sffair on 2022-05-24.
//

import Foundation

extension DateFormatter {
    
    static let iso8601Short: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.calendar = Calendar(identifier: .iso8601)
        return formatter
    }()
}
