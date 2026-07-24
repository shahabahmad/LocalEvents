//
//  MockLocationService.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import Foundation
import CoreLocation
import Combine

class MockLocationService: ILocationService {
    
    private let locationSubject =
    CurrentValueSubject<Coordinate, Never>(Coordinate(latitude: 43.77, longitude: -79.24))
    
    private var timerCancellable: AnyCancellable?
    
    var authorizationStatus: CLAuthorizationStatus {
        .authorizedAlways
    }

    var locationPublisher: AnyPublisher<Coordinate, Never> {
        locationSubject.eraseToAnyPublisher()
    }

    func requestPermission() { }

    func startUpdatingLocation() {
        timerCancellable = Timer.publish(every: 10, on: .main, in: .common)
            .autoconnect()
            .sink {[weak self] _ in
                var coordinate = self?.locationSubject.value
                let lat = coordinate!.latitude + 0.01
                let longitude = coordinate!.longitude + 0.01
                self?.locationSubject.send(
                    Coordinate(
                        latitude: lat,
                        longitude: longitude
                    )
                )
            }
    }

    func stopUpdatingLocation() {
        timerCancellable?.cancel()
        timerCancellable = nil
    }
    
    func startTimer() {
        timerCancellable?.cancel()
        timerCancellable = nil
        startUpdatingLocation()

    }
}

/*
 func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
     guard let location = locations.last else {
         return
     }
     locationSubject.send(
         Coordinate(
             latitude: location.coordinate.latitude,
             longitude: location.coordinate.longitude
         )
     )
 }
 */
