//
//  Endpoint.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import Foundation

enum Endpoint {
    case getEvents(Coordinate)
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = NetworkConstant.scheme
        components.host = NetworkConstant.host
        let path = NetworkConstant.path
        switch self {
        case .getEvents(let coordinate):
            components.queryItems = [
                URLQueryItem(name: "lat", value: "\(coordinate.latitude)"),
                URLQueryItem(name: "lng", value: "\(coordinate.longitude)")
            ]
            components.path = path + NetworkConstant.nearbyEventsPath
        }
        return components.url
    }
}
