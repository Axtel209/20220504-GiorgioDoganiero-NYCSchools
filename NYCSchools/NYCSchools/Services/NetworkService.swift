//
//  NetworkService.swift
//  NYCSchools
//
//  Created by Giorgio Doganiero on 4/30/22.
//

import Foundation
import Combine

struct NetworkService {    
    static let shared = NetworkService()
    private init() { }
    
    // MARK: - Request
    
    func request<T: Codable>(_ url: URL, expecting: T.Type) -> AnyPublisher<T, Error> {
        let decoder = JSONDecoder()
                
        return URLSession.shared.dataTaskPublisher(for: url)
                                .mapError { $0 as Error }
                                .map(\.data)
                                .decode(type: expecting, decoder: decoder)
                                .eraseToAnyPublisher()
    }
}

