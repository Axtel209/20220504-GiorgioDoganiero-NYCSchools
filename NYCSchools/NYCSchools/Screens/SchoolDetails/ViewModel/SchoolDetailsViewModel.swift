//
//  SchoolDetailsViewModel.swift
//  NYCSchools
//
//  Created by Giorgio Doganiero on 5/2/22.
//

import Foundation

class SchoolDetailsViewModel {
    // MARK: - Properties
    let school: SchoolModel
    
    // MARK: - Lifecycle
    
    init(_ school: SchoolModel) {
        self.school = school
        fetchSatScores()
    }
    
    private func fetchSatScores() {
        let endpoint = Endpoint.sat(school.dbn)
        NetworkService.shared.request(endpoint.url, expecting: SchoolModel.self)
    }
}
