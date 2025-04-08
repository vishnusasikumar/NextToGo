//
//  GetRacesUseCase.swift
//  NextToGo
//
//  Created by Admin on 23/03/2025.
//

import Foundation

protocol GetRacesUseCase {
    func getRaces(with pageCount: Int) async -> [RaceSummary]
}

struct GetRacesUseCaseImpl: GetRacesUseCase {
    var repo: RacingRepositoryProtocol
    let racesPerPage = 5
    
    init(repo: RacingRepositoryProtocol) {
        self.repo = repo
    }
    
    func getRaces(with pageCount: Int) async -> [RaceSummary] {
        do {
            let racesDictionary = try await repo.getRaces(with: pageCount * racesPerPage)
            var raceArray = racesDictionary.map({ $0.value }).compactMap{ $0 }
//            raceArray = raceArray.filter({ $0.advertisedStart.formattedDate.distance(to: Date.now) > 0 }) // Filter out any dates that are in the past
            return raceArray
        } catch(let error) {
            print(error)
            return []
        }
    }
}
