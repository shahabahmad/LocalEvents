//
//  IMapsService.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import Foundation

protocol IMapsService {
    func openMap(
        coordinate: Coordinate,
        name: String
    )
}
