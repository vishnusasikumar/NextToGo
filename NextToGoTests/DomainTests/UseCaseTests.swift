//
//  UseCaseTests.swift
//  NextToGoTests
//
//  Created by Admin on 07/04/2025.
//

import Testing
@testable import NextToGo
import Foundation

struct MockRacingRepository: RacingRepositoryProtocol {
    var racing: Racing?
    var error: APIError?
    
    init(racing: Racing? = nil, error: APIError? = nil) {
        self.racing = racing
        self.error = error
    }
    
    
    func getRaces(with count: Int) async throws -> [String : RaceSummary] {
        if let racing {
            return racing.data.raceSummaries
        } else {
            if let error {
                throw APIError.failed(error: error)
            }
        }
        throw APIError.unknownError
    }
}

@Suite("UseCase protocol tests") struct UseCaseTests: FetchMockJson {
    
    var repository: RacingRepositoryProtocol
    var useCase: GetRacesUseCaseImpl
    
    init() async throws {
        repository = MockRacingRepository()
        useCase = GetRacesUseCaseImpl(repo: repository)
    }

    @Test("Repository successfully fetches data") mutating func repositoryFetchSuccess() async throws {
        let result: Racing = try #require(try decodeJson(from: "RacingMockResponse"))
        repository = MockRacingRepository(racing: result)
        useCase = GetRacesUseCaseImpl(repo: repository)
        let raceSummaries = try #require(await useCase.getRaces(with: 1), "UseCase should return first 5 values")
        #expect(raceSummaries.count == count)
    }
    
    @Test("Repository failed to fetch data") mutating func repositoryFetchFailure() async throws {
        repository = MockRacingRepository(racing: nil, error: APIError.errorDecode)
        await #expect(throws: APIError.self) {
            try await repository.getRaces(with: 1)
        }
    }

}
