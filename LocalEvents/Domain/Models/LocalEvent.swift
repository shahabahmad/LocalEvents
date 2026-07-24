//
//  LocalEvent.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import Foundation

struct LocalEvent: Identifiable, Hashable {
    let id: Int
    let title: String
    let location: Coordinate
    let time: Date
    let imageURLString: String?
    
    var isBookMarked: Bool = false
}
