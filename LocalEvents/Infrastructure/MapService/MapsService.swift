//
//  MapsService.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import Foundation
import MapKit

final class MapsService: IMapsService {

    func openMap(coordinate: Coordinate, name: String) {

        let coordinate = CLLocationCoordinate2D(
            latitude: coordinate.latitude,
            longitude: coordinate.longitude
        )

        let placemark = MKPlacemark(
            coordinate: coordinate
        )

        let mapItem = MKMapItem(
            placemark: placemark
        )

        mapItem.name = name

        mapItem.openInMaps(
            launchOptions: [
                MKLaunchOptionsDirectionsModeKey:
                    MKLaunchOptionsDirectionsModeDriving
            ]
        )
    }
}
