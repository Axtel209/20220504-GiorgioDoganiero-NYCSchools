//
//  Endpoint.swift
//  NYCSchools
//
//  Created by Giorgio Doganiero on 5/1/22.
//

import Foundation

struct Endpoint {    
    var path: String
    var queryItems: [URLQueryItem] = []
    
    /// avoid initializing, instead use static properties or functions
    fileprivate init(path: String, queryItems: [URLQueryItem] = []) {
        self.path = path
        self.queryItems = queryItems
    }
}

// MARK: - Build endpoint
extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "data.cityofnewyork.us"
        components.path = "/resource" + path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("Endpoint: Invalid URL")
        }
        
        return url
    }
}

// MARK: - Schools endpoint
extension Endpoint {
    private static var schoolPath = "/s3k6-pzi2.json"
    
    /// Return all schools
    static var schools: Self {
        return Endpoint(path: schoolPath)
    }
    
    /// Return all schools ordered by id
    /// - Parameters:
    ///   - count: The number of results to return.
    ///   - offset: The index where to start the returned list of results.
    static func schools(count: Int, offset: Int) -> Self {
        let queryItems = [
            URLQueryItem(name: "$limit", value: "\(count)"),
            URLQueryItem(name: "$offset", value: "\(offset)"),
            URLQueryItem(name: "$order", value: "dbn")
        ]
        
        return Endpoint(path: schoolPath, queryItems: queryItems)
    }
    
    /// Return a school
    /// - Parameters:
    ///   - id: The dbn id of the school
    static func school(id: String) -> Self {
        let queryItems = [
            URLQueryItem(name: "dbn", value: id)
        ]
        return Endpoint(path: schoolPath, queryItems: queryItems)
    }
}

// MARK: - SAT Results endpoint
extension Endpoint {
    private static var satPath = "/f9bf-2cp4.json"
    
    /// Return all schools SAT results
    static var sat: Self {
        return Endpoint(path: satPath)
    }
    
    /// Return all sat scores ordered by id
    /// - Parameters:
    ///   - count: The number of results to return.
    ///   - offset: The index where to start the returned list of results.
    static func sat(count: Int, offset: Int) -> Self {
        let queryItems = [
            URLQueryItem(name: "$limit", value: "\(count)"),
            URLQueryItem(name: "$offset", value: "\(offset)"),
            URLQueryItem(name: "$order", value: "dbn")
        ]
        
        return Endpoint(path: satPath, queryItems: queryItems)
    }
    
    /// Return SAT results for school
    /// - Parameters:
    ///   - schoolId: The dbn id of the school
    static func sat(_ schoolId: String) -> Self {
        let queryItems = [
            URLQueryItem(name: "dbn", value: schoolId),
        ]
        
        return Endpoint(path: satPath, queryItems: queryItems)
    }
}
