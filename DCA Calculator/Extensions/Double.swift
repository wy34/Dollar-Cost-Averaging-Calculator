//
//  Double.swift
//  DCA Calculator
//
//  Created by William Yeung on 4/8/21.
//

import Foundation

extension Double {
    func roundTo(places: Int) -> Double {
        let base = pow(10, Double(places))
        return floor(self * base) / base
    }
    
    func toTwoPlaces() -> Double {
        return roundTo(places: 2)
    }
    
    func currencyValue() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = .current
        numberFormatter.numberStyle = .currency
        let number = NSNumber(value: self)
        return numberFormatter.string(from: number) ?? ""
    }
}

