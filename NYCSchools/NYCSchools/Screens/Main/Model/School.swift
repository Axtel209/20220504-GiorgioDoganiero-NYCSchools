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
    let name: String
    let description: String
    let phoneNumber: String
    let email: String?
    let website: String
    let totalStudents: Int
    var street: String
    var city: String
    var state: String
    var zip: String
    private let latitude: Double
    private let longitude: Double
    
    // Computed Properties
    var shortAddress: String {
        get { return "\(city), \(state)"}
    }
    
    var address: String {
        get { return "\(street), \(city) \(state) \(zip)" }
    }
    
    var coordinates: (latitude: Double, longitude: Double) {
        get {
            return (latitude: latitude, longitude: longitude)
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case dbn
        case name = "school_name"
        case description = "overview_paragraph"
        case phoneNumber = "phone_number"
        case email = "school_email"
        case website
        case totalStudents = "total_students"
        case latitude
        case longitude
        case street = "primary_address_line_1"
        case city
        case state = "state_code"
        case zip
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func ==(lhs: School, rhs: School) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

// MARK: - Decoder
extension School {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dbn = try values.decode(String.self, forKey: .dbn)
        name = try values.decode(String.self, forKey: .name)
        description = try values.decode(String.self, forKey: .description)
        phoneNumber = try values.decode(String.self, forKey: .phoneNumber)
        email = try? values.decode(String.self, forKey: .email)
        website = try values.decode(String.self, forKey: .website)
        totalStudents = Int(try values.decode(String.self, forKey: .totalStudents)) ?? 0
        latitude = Double(try values.decode(String.self, forKey: .latitude)) ?? 0.0
        longitude = Double(try values.decode(String.self, forKey: .longitude)) ?? 0.0
        street = try values.decode(String.self, forKey: .street)
        city = try values.decode(String.self, forKey: .city)
        state = try values.decode(String.self, forKey: .street)
        zip = try values.decode(String.self, forKey: .zip)
    }
}
