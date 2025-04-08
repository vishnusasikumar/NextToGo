//
//  RacingCoreDataImpl.swift
//  NextToGo
//
//  Created by Admin on 23/03/2025.
//

import SwiftData
import SwiftUI

struct RacingSwiftDataImpl: RacingRepositoryProtocol {
    @Query private var nextRaces: [RacingData]
    
    func getRaces(with count: Int) async -> [String : RaceSummary] {
        nextRaces.compactMap({ $0.data }).compactMap({ $0.raceSummaries }).first!
    }
}
