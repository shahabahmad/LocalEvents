//
//  NetworkError.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case noData
    case invalidResponse
    case decodingError(Error)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .badUrl:
            return "Invalid URL"
        case .noData:
            return "No data returned from server"
        case .invalidResponse:
            return "Invalid response from server"
        case .decodingError(let error):
            if let error = error as? LocalizedError {
                return error.errorDescription
            }
            return "Failed to decode response"
        }
    }
}
