//
//  EventDto.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import Foundation

struct CoordinateDto: Decodable {
    let latitude: Double
    let longitude: Double
    
    func toDomain() -> Coordinate {
        Coordinate(latitude: latitude, longitude: longitude)
    }
}

struct EventDto: Decodable {
    let id: Int
    let title: String
    let location: CoordinateDto
    let time: String
    let imageURLString: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, location, time
        case imageURLString = "image_url"
    }
    
    func toDomain() throws -> LocalEvent {
        
        let dateParseStrategy = Date.ParseStrategy(
            format: "\(year: .defaultDigits)-\(month: .twoDigits)-\(day: .twoDigits)",
            timeZone: .current
        )
        let eventTime = try Date(time, strategy: dateParseStrategy)
        return LocalEvent(id: id,
                          title: title,
                          location: location.toDomain(),
                          time: eventTime,
                          imageURLString: imageURLString)
    }
}
