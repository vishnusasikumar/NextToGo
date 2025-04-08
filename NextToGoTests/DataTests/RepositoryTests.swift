//
//  RepositoryTests.swift
//  NextToGoTests
//
//  Created by Admin on 07/04/2025.
//

import Testing
@testable import NextToGo
import Foundation

let count = 5 //According to the mock response

class MockNetworkService: NetworkServiceProtocol {
    
    var result: Data?
    var error: APIError?
    var responseCode: Int
    
    init(result: Data? = nil, error: APIError? = nil, responseCode: Int = 200) {
        self.result = result
        self.error = error
        self.responseCode = responseCode
    }

    func request<T:Decodable>(_ queryItems: [URLQueryItem]) async throws -> Result<T, APIError> {
        if let result {
            guard let response = HTTPURLResponse(url: Constants.urlComponents.url!, statusCode: responseCode, httpVersion: nil, headerFields: nil) else {
                throw APIError.error_500
            }
            return try await completionHandler(result, response)
        } else {
            if let error {
                throw error
            } else {
                throw APIError.error_500
            }
        }
    }
    
    func cancelAllTasks() {
        // Empty conformance of protocol
    }
}

@Suite("Repository protocol tests") struct RepositoryTests: FetchMockJson {
    
    var mockNetworService: NetworkServiceProtocol!
    var repository: RacingRepositoryImpl!
    
    init() async throws {
        mockNetworService = MockNetworkService()
        repository = RacingRepositoryImpl(service: mockNetworService)
    }

    @Test("Repository successfully fetches data") mutating func repositoryFetchSuccess() async throws {
        let data = try #require(try loadMockResponse(with: "RacingMockResponse"), "Result mocks need to be fetched")
        mockNetworService = MockNetworkService(result: data)
        repository = RacingRepositoryImpl(service: mockNetworService)
        let raceSummaries = try #require(await repository.getRaces(with: count), "Repository should return a value")
        #expect(raceSummaries.count == count)
    }
    
    @Test("Repository failed to fetch data") mutating func repositoryFetchFailure() async throws {
        mockNetworService = MockNetworkService(result: nil, error: APIError.error_204, responseCode: 204)
        repository = RacingRepositoryImpl(service: mockNetworService)
        await #expect(throws: APIError.self) {
            try await repository.getRaces(with: count)
        }
    }
    
    
}
