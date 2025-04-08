//
//  RacingRepository.swift
//  NextToGo
//
//  Created by Admin on 23/03/2025.
//

protocol RacingRepositoryProtocol {
    func getRaces(with count: Int) async throws -> [String: RaceSummary]
}
