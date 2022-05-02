//
//  School.swift
//  NYCSchools
//
//  Created by Giorgio Doganiero on 4/30/22.
//

import Foundation

struct School: Codable, Hashable {
    let identifier = UUID()
    let dbn: String
    let schoolName: String
    
    private enum CodingKeys: String, CodingKey {
        case dbn, schoolName
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func ==(lhs: School, rhs: School) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
