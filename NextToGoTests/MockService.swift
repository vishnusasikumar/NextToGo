//
//  MockService.swift
//  NextToGo
//
//  Created by Admin on 07/04/2025.
//

import Foundation

class MockService: NetworkServiceProtocol {
    private let responseCode: Int
    private let shouldError: Bool
    
    init(responseCode: Int = 200, shouldError: Bool = false) {
        self.responseCode = responseCode
        self.shouldError = shouldError
    }
    
    // Hardcoded to return just the racing data for now
    func request<T:Decodable>(_ queryItems: [URLQueryItem]) async throws -> Result<T, APIError> {
        let response = HTTPURLResponse(url: Constants.urlComponents.url!, statusCode: responseCode, httpVersion: nil, headerFields: nil)
        let url = Bundle.main.url(forResource: "RacingMockResponse", withExtension: "json")!
        var data: Data? = nil
        if !shouldError {
            data = try Data(contentsOf: url)
        }
        
        return try await completionHandler(data, response!)
    }
    
    func cancelAllTasks() {
        // Empty conformance of protocol
    }
}


// Preview Helper
extension MockService {
    static var sampleSummary: RaceSummary {
        load( "RacingSummaryMockResponse.json")
    }
    
    static var sampleSummaries: [RaceSummary] {
        load("RacingMockResponse.json")
    }
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
