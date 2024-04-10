//
//  DateFormatter.swift
//  GithubProfile
//
//  Created by 박현렬 on 4/10/24.
//

import Foundation

extension DateFormatter {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.timeZone = TimeZone(identifier: "UTC")
        return formatter
    }()
    
    static let customFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy/MM/dd HH:mm"
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        return formatter
    }()
}

extension String {
    func convertToCustomFormat() -> String {
        guard let date = DateFormatter.iso8601Full.date(from: self) else {
            return self
        }
        return DateFormatter.customFormat.string(from: date)
    }
}
