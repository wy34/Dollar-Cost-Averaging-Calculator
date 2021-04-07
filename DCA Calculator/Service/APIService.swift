//
//  APIService.swift
//  DCA Calculator
//
//  Created by William Yeung on 4/5/21.
//

import Foundation
import Combine

class APIService {
    enum APIServiceError: Error {
        case encoding
        case badRequest
    }
    
    enum URLString {
        static var keys = ["FZ1TZCZ5IOF05DH2", "L5P4U8YV5X3A6BEG", "3E8L1JRJ2Z8CGP0V"]

        func api_Key() -> String {
            return URLString.keys.randomElement() ?? ""
        }
        
        static func symbolsURLString(searchTerm: String) -> String {
            return "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=\(searchTerm)&apikey=\(String(describing: api_Key)))"
        }
        
        static func timeSeriesURLString(symbol: String) -> String {
            return "https://www.alphavantage.co/query?function=TIME_SERIES_MONTHLY_ADJUSTED&symbol=\(symbol)&apikey=\(String(describing: api_Key))"
        }
    }

    
    func fetchData<T: Codable>(urlString: String) -> AnyPublisher<T, Error> {
        guard let urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return Fail(error: APIServiceError.encoding).eraseToAnyPublisher()
        }
        
        guard let url = URL(string: urlString) else {
            return Fail(error: APIServiceError.badRequest).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map({ $0.data })
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func fetchSymbols(searchTerm: String) -> AnyPublisher<SearchResult, Error> {
        return fetchData(urlString: URLString.symbolsURLString(searchTerm: searchTerm))
    }
    
    func fetchTimeSeries(symbol: String) -> AnyPublisher<TimeSeriesMonthlyAjusted, Error> {
        return fetchData(urlString: URLString.timeSeriesURLString(symbol: symbol))
    }
}

