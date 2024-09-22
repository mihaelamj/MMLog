//
//  Date+Extension.swift
//  MMLog
//
//  Created by Mihaela MJ on 23.09.2024..
//

import Foundation

public extension Date {
    static func loggableCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy. HH:mm:ss"
        return dateFormatter.string(from: Date())
    }
}
