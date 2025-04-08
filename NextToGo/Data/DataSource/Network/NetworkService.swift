//
//  NetworkService.swift
//  NextToGo
//
//  Created by Admin on 23/03/2025.
//

import Foundation

enum APIError: Error {
    case error_204
    case error_400
    case error_401
    case error_404
    case error_500
    case invalidUrl
    case errorDecode
    case failed(error: Error)
    case failedRequest(error: Error)
    case requestTimedOut
    case unknownError
}

enum NetworkStatus: Int {
    // Undefined error
    case undefined              = 0
    // 2xx Success
    case success                = 200
    case noContent              = 204
    // 4xx Client errors
    case badRequest             = 400
    case unauthorized           = 401
    case forbidden              = 403
    case notFound               = 404
    case methodNotAllowed       = 405
    //5xx Server errors
    case internalServerError    = 500
    case notImplemented         = 501
    case badGateway             = 502
    case serviceUnavailable     = 503
}

protocol NetworkProtocol {
    func request<T:Decodable>(_ queryItems: [URLQueryItem]) async throws -> Result<T, APIError>
    func cancelAllTasks()
}

protocol NetworkServiceProtocol: NetworkProtocol, CompletionHandler { }

class NetworkService: NetworkServiceProtocol {
    private var session: URLSession
    
    init() {
        session = URLSession(configuration: .default)
    }
    
    public func request<T:Decodable>(_ queryItems: [URLQueryItem]) async throws -> Result<T, APIError> {
        guard let urlValue = Constants.urlComponents.url else {
            throw APIError.invalidUrl
        }
        
        let url = urlValue.appending(queryItems: queryItems)
        
        return try await makeRequest(url)
    }
    
    private func makeRequest<T:Decodable>(_ url: URL) async throws -> Result<T, APIError> {
        let (data, resp) = try await session.data(from: url)
        guard let response = resp as? HTTPURLResponse else {
            return .failure(APIError.unknownError)
        }
        return try await completionHandler(data, response)
    }
    
    func cancelAllTasks() {
        session.getAllTasks { (tasks) in
            for task in tasks {
                task.cancel()
            }
        }
    }
}
