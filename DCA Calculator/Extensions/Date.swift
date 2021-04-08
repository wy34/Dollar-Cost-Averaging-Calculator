//
//  Date.swift
//  DCA Calculator
//
//  Created by William Yeung on 4/7/21.
//

import UIKit

extension Date {
    func convertToString() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: self)
    }
}
