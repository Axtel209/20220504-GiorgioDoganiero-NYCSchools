//
//  MainViewModel.swift
//  NYCSchools
//
//  Created by Giorgio Doganiero on 4/30/22.
//

import Foundation

final class MainViewModel {
    // MARK: - Properties
    
    
    // MARK: - Setup
    
    init() {
        fetchSchools()
    }
    
    /// Return all schools.
    /// - Parameters:
    ///   - limit: The number of results to return.
    ///   - offset: The index where to start the returned list of results.
    ///   - order: The order results are return.
    func fetchSchools(_ limit: Int = 5, offset: Int = 0, order: String = ":id") {
        // Given more time I would prefer to make querys more dynamic
        let query = ["$limit": String(limit), "$offset": String(offset), "$order": order]
        
        NetworkService.shared.request(.schools, query: query, expecting: [School].self) { result in
            switch result {
            case .success(let schools):
                print(schools)
            case .failure(let error):
                print(error)
            }
        }
    }
}
