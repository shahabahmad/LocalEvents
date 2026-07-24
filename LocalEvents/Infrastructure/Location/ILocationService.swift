//
//  ILocationService.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import Foundation
import CoreLocation
import Combine

protocol ILocationService {
    var authorizationStatus: CLAuthorizationStatus { get }

    var locationPublisher: AnyPublisher<Coordinate, Never> { get }

    func requestPermission()

    func startUpdatingLocation()

    func stopUpdatingLocation()
}
