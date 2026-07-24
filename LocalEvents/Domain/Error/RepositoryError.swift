//
//  RepositoryError.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import Foundation

enum RepositoryError: LocalizedError {
    case unavailable
    case dataUnavailable
    case unknown

    var errorDescription: String? {
        switch self {
        case .unavailable:
            return "Unable to load events. Please try again."

        case .dataUnavailable:
            return "Events are currently unavailable."

        case .unknown:
            return "Something went wrong."
        }
    }
}
