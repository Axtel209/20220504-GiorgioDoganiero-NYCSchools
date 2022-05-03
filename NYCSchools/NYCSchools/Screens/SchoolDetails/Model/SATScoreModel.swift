//
//  SATScoresModel.swift
//  NYCSchools
//
//  Created by Giorgio Doganiero on 5/2/22.
//

import Foundation

struct SATScoreModel: Hashable {
    let identifier = UUID()
    let dbn: String
    let totalTestTaken: Int
    let readingAvgScore: Int
    let mathAvgScore: Int
    let writingAvgScore: Int
    
    // MARK: - Hashable Conformance
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func ==(lhs: SATScoreModel, rhs: SATScoreModel) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

extension SATScoreModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case dbn
        case totalTestTaken = "num_of_sat_test_takers"
        case readingAvgScore = "sat_critical_reading_avg_score"
        case mathAvgScore = "sat_math_avg_score"
        case writingAvgScore = "sat_writing_avg_score"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dbn = try values.decode(String.self, forKey: .dbn)
        totalTestTaken = Int(try values.decode(String.self, forKey: .totalTestTaken)) ?? 0
        readingAvgScore = Int(try values.decode(String.self, forKey: .readingAvgScore)) ?? 0
        mathAvgScore = Int(try values.decode(String.self, forKey: .mathAvgScore)) ?? 0
        writingAvgScore = Int(try values.decode(String.self, forKey: .writingAvgScore)) ?? 0
    }
}
