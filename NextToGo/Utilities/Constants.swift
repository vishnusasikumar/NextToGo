//
//  Constants.swift
//  NextToGo
//
//  Created by Admin on 23/03/2025.
//

import Foundation

struct Constants {
    /// Configure the URL for our request.
    /// In this case, an example JSON response..
    static let baseURL = "https://api.neds.com.au/rest/v1/racing/"
    static let urlComponents = URLComponents(string: baseURL)!
    static func transactionDetails(id: Int) -> String {
        // Should return something like below
        // return "\(baseURL)/transactions/\(id)"
        return "\(baseURL)"
    }
    
}
