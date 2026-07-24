//
//  DistanceCalculator.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import Foundation
import CoreLocation

class DistanceCalculator {

    func calculate(
        from: Coordinate,
        to: Coordinate
    ) -> Double {

        let fromLocation = CLLocation(
            latitude: from.latitude,
            longitude: from.longitude
        )

        let toLocation = CLLocation(
            latitude: to.latitude,
            longitude: to.longitude
        )

        return fromLocation.distance(
            from: toLocation
        )
    }
}
