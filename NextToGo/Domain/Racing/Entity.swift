//
//  Entity.swift
//  NextToGo
//
//  Created by Admin on 23/03/2025.
//

import Foundation
import SwiftData

// MARK: - Racing
struct Racing: Codable, Identifiable {
    typealias Identifier = Int
    var id: Identifier
    var data: DataClass
    var message: String
    
    enum CodingKeys: String, CodingKey {
        case id = "status"
        case data
        case message
    }
    
    func convertToDTO() -> RacingData {
        RacingData(id: id, data: data.convertToDTO(), message: message)
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    var nextToGoIDS: [String]
    var raceSummaries: [String: RaceSummary]
    
    enum CodingKeys: String, CodingKey {
        case nextToGoIDS = "next_to_go_ids"
        case raceSummaries = "race_summaries"
    }
    
    func convertToDTO() -> DataClassDTO {
        DataClassDTO(nextToGoIDS: nextToGoIDS, raceSummaries: raceSummaries)
    }
}

// MARK: - RaceSummary
struct RaceSummary: Equatable, Codable, Identifiable {
    typealias Identifier = String
    var id: Identifier
    var raceName: String
    var raceNumber: Int
    var meetingID, meetingName, categoryID: String
    var advertisedStart: AdvertisedStart
    var raceForm: RaceForm
    var venueID, venueName, venueState, venueCountry: String
    
    enum CodingKeys: String, CodingKey {
        case id = "race_id"
        case raceName = "race_name"
        case raceNumber = "race_number"
        case meetingID = "meeting_id"
        case meetingName = "meeting_name"
        case categoryID = "category_id"
        case advertisedStart = "advertised_start"
        case raceForm = "race_form"
        case venueID = "venue_id"
        case venueName = "venue_name"
        case venueState = "venue_state"
        case venueCountry = "venue_country"
    }
    
    static func == (lhs: RaceSummary, rhs: RaceSummary) -> Bool {
        lhs.id == rhs.id
    }
    
}

// MARK: - AdvertisedStart
struct AdvertisedStart: Codable {
    var seconds: Int
    
    var formattedDate: Date {
        Date(timeIntervalSince1970: TimeInterval(seconds))
    }
    
    var formattedDateStr: String {
        // ask for the full relative date
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full

        // get date relative to the current date
        let relativeDate = formatter.localizedString(for: Date.now, relativeTo: formattedDate)
        return relativeDate
    }
}

// MARK: - RaceForm
struct RaceForm: Codable {
    var distance: Int
    var distanceType: DistanceType
    var distanceTypeID: String
    var trackCondition: DistanceType?
    var trackConditionID: String?
    var weather: DistanceType?
    var weatherID, raceComment: String?
    var additionalData: String
    var generated: Int
    var silkBaseURL: SilkBaseURL
    var raceCommentAlternative: String?
    
    enum CodingKeys: String, CodingKey {
        case distance
        case distanceType = "distance_type"
        case distanceTypeID = "distance_type_id"
        case trackCondition = "track_condition"
        case trackConditionID = "track_condition_id"
        case weather
        case weatherID = "weather_id"
        case raceComment = "race_comment"
        case additionalData = "additional_data"
        case generated
        case silkBaseURL = "silk_base_url"
        case raceCommentAlternative = "race_comment_alternative"
    }
}

// MARK: - DistanceType
struct DistanceType: Codable {
    var id, name, shortName: String
    var iconURI: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case shortName = "short_name"
        case iconURI = "icon_uri"
    }
}

enum SilkBaseURL: String, Codable {
    case drr38Safykj6SCloudfrontNet = "drr38safykj6s.cloudfront.net"
}

class PublishedDate: ObservableObject {
    var date: Date

    /// Manually creating a publisher that will emits once a second
    var objectWillChange = Timer.publish(every: 1, on: .main, in:.common).autoconnect()
    
    init(date: Date) {
        self.date = date
    }
}
