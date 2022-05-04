//
//  School.swift
//  NYCSchools
//
//  Created by Giorgio Doganiero on 4/30/22.
//

import Foundation

struct SchoolModel: Hashable {
    // MARK: - Properties
    let identifier = UUID()
    let dbn: String
    let name: String
    let description: String
    let phoneNumber: String
    let email: String?
    let website: String
    let grades: String
    let totalStudents: Int
    let street: String
    let city: String
    let state: String
    let zip: String
    var satScores: SATScoreModel?
    private let bus: String
    private let subway: String
    private let extracurricular: String?
    private let sports: String?
    private let latitude: Double
    private let longitude: Double
    
    // MARK: - Computed Helper Properties
    
    var hasBus: Bool {
        get { return bus != "N/A" }
    }

    var hasSubway: Bool {
        get { return subway != "N/A" }
    }
    
    var hasExtracurricular: Bool {
        get { return extracurricular != nil }
    }
    
    var hasSposrts: Bool {
        get {
            guard let sports = sports else { return false }
            return !sports.isEmpty
        }
    }
    
    var shortAddress: String {
        get { return "\(street), \(city)"}
    }
    
    var address: String {
        get { return "\(street), \(city) \(state) \(zip)" }
    }
    
    var coordinates: (latitude: Double, longitude: Double) {
        get {
            return (latitude: latitude, longitude: longitude)
        }
    }
    
    // MARK: - Hashable Conformance
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func ==(lhs: SchoolModel, rhs: SchoolModel) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

// MARK: - Codable
extension SchoolModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case dbn
        case name = "school_name"
        case description = "overview_paragraph"
        case phoneNumber = "phone_number"
        case email = "school_email"
        case website
        case grades = "finalgrades"
        case totalStudents = "total_students"
        case extracurricular = "extracurricular_activities"
        case sports = "school_sports"
        case bus
        case subway
        case latitude
        case longitude
        case street = "primary_address_line_1"
        case city
        case state = "state_code"
        case zip
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dbn = try values.decode(String.self, forKey: .dbn)
        name = try values.decode(String.self, forKey: .name)
        description = try values.decode(String.self, forKey: .description)
        phoneNumber = try values.decode(String.self, forKey: .phoneNumber)
        email = try? values.decode(String.self, forKey: .email)
        website = try values.decode(String.self, forKey: .website)
        grades = try values.decode(String.self, forKey: .grades)
        totalStudents = Int(try values.decode(String.self, forKey: .totalStudents)) ?? 0
        bus = try values.decode(String.self, forKey: .bus)
        subway = try values.decode(String.self, forKey: .subway)
        sports = try? values.decode(String.self, forKey: .sports)
        extracurricular = try? values.decode(String.self, forKey: .extracurricular)
        let lat = try? values.decode(String.self, forKey: .latitude)
        let lon = try? values.decode(String.self, forKey: .longitude)
        latitude = Double(lat ?? "") ?? 0.0
        longitude = Double(lon ?? "") ?? 0.0
        street = try values.decode(String.self, forKey: .street)
        city = try values.decode(String.self, forKey: .city)
        state = try values.decode(String.self, forKey: .state)
        zip = try values.decode(String.self, forKey: .zip)
    }
}
