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
    let currency: String?
    let type: String?
    
    enum CodingKeys: String, CodingKey {
        case symbol = "1. symbol"
        case name = "2. name"
        case currency = "3. currency"
        case type = "4. type"
    }
}
