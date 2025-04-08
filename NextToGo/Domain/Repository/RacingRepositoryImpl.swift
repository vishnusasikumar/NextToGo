//
//  RacingRepositoryImpl.swift
//  NextToGo
//
//  Created by Admin on 23/03/2025.
//

import Foundation
import SwiftData
import SwiftUICore

struct RacingRepositoryImpl: RacingRepositoryProtocol {
    private let service : NetworkServiceProtocol
    //    @Environment(\.modelContext) var modelContext
    
    init(service: NetworkServiceProtocol) {
        self.service = service
    }
    
    func getRaces(with count: Int) async throws -> [String: RaceSummary] {
        do {
            let queryItems = [URLQueryItem(name: "method", value: "nextraces"), URLQueryItem(name: "count", value: "\(count)")]
            let raceResult: Result<Racing, APIError> = try await service.request(queryItems)
            switch raceResult {
            case .success(let racing):
                // Adding retrieved data into the SwiftData impl
                // modelContext.insert(racing.convertToDTO())
                return racing.data.raceSummaries
            case .failure(let error):
                throw APIError.failed(error: error)
            }
        } catch(let error) {
            throw APIError.failed(error: error)
        }
    }
}
