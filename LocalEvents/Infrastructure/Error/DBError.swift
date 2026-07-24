//
//  CoreDataError.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import Foundation

enum DBError: Error {
    case saveFailed(Error)
    case fetchFailed(Error)
    case other
}
