//
//  EventEntity.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import Foundation

extension EventEntity {

    func toDomain() -> LocalEvent {

        LocalEvent(
            id: Int(id),
            title: title ?? "",
            location: Coordinate(
                latitude: latitude,
                longitude: longitude
            ),
            time: time ?? Date(),
            imageURLString: imageUrlString,
            isBookMarked: bookmark != nil
        )
    }
}
