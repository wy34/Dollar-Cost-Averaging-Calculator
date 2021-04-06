//
//  APIService.swift
//  DCA Calculator
//
//  Created by William Yeung on 4/5/21.
//

import Foundation
import Combine

class APIService {
    let keys = ["FZ1TZCZ5IOF05DH2", "L5P4U8YV5X3A6BEG", "3E8L1JRJ2Z8CGP0V"]
    
    var api_Key: String {
        return keys.randomElement() ?? ""
    }

    func fetchSymbolsPublisher(keywords: String) -> AnyPublisher<SearchResult, Error> {
        let urlString = "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=\(keywords)&apikey=\(api_Key)"
        let url = URL(string: urlString)!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map({ $0.data })
            .decode(type: SearchResult.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
