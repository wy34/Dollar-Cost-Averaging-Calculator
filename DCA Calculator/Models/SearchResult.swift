//
//  SearchResult.swift
//  DCA Calculator
//
//  Created by William Yeung on 4/5/21.
//

import Foundation

struct SearchResult: Codable {
    let items: [Company]
    
    enum CodingKeys: String, CodingKey {
        case items = "bestMatches"
    }
}

struct Company: Codable {
    let symbol: String
    let name: String
    let type: String?
    let currency: String?

    enum CodingKeys: String, CodingKey {
        case symbol = "1. symbol"
        case name = "2. name"
        case type = "3. type"
        case currency = "8. currency"
    }
}
