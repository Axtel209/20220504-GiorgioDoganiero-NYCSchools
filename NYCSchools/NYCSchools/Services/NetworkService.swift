//
//  NetworkService.swift
//  NYCSchools
//
//  Created by Giorgio Doganiero on 4/30/22.
//

import Foundation

struct NetworkService {
    fileprivate enum NetworkError: Error {
        case invalidURL
        case invalidData
    }
    
    enum BaseURL: String {
        case schools = "https://data.cityofnewyork.us/resource/s3k6-pzi2.json"
        case satScores = "https://data.cityofnewyork.us/resource/f9bf-2cp4.json"
    }
    
    typealias requestCompletion<T: Codable> = (Result<T, Error>) -> Void
    
    static let shared = NetworkService()
    private init() { }
    
    // MARK: - Request
    
    func request<T: Codable>(_ url: BaseURL, query: [String: String], expecting: T.Type, completion: @escaping requestCompletion<T>) {
        // Build url request with query
        var urlComponents = URLComponents(string: url.rawValue)
        urlComponents?.queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        // Validate url
        guard let url = urlComponents?.url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Bailed on error
            guard let data = data,                              // is data valid
                  let response = response as? HTTPURLResponse,  // HTTP response
                  200 ..< 300 ~= response.statusCode            // is a valid status code 2XX
            else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(NetworkError.invalidData))
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let result = try decoder.decode(expecting, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

