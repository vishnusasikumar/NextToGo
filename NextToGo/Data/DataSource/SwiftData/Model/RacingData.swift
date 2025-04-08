//
//  RacingData.swift
//  NextToGo
//
//  Created by Admin on 07/04/2025.
//

import Foundation
import SwiftData

@Model
class RacingData: Identifiable {
    typealias Identifier = Int
    var id: Identifier
    var message: String
    @Relationship(deleteRule: .cascade) var data: DataClassDTO
    
    enum CodingKeys: String, CodingKey {
        case id = "status"
        case data
        case message
    }
    
    init(id: Identifier, data: DataClassDTO, message: String) {
        self.id = id
        self.data = data
        self.message = message
    }
}

@Model
class DataClassDTO {
    var nextToGoIDS: [String]
    var raceSummaries: [String: RaceSummary]

    enum CodingKeys: String, CodingKey {
        case nextToGoIDS = "next_to_go_ids"
        case raceSummaries = "race_summaries"
    }

    init(nextToGoIDS: [String], raceSummaries: [String: RaceSummary]) {
        self.nextToGoIDS = nextToGoIDS
        self.raceSummaries = raceSummaries
    }
}
