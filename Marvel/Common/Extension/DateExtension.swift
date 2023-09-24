//
//  DateExtension.swift
//  Marvel
//
//  Created by Charbel Hasrouni on 24/09/2023.
//

import Foundation

extension Date {
    //Generate a timestamp in millisecond
    func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
