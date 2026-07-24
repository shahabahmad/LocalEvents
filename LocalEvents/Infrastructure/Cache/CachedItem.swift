//
//  CachedItem.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import Foundation

struct CachedItem {

    let data: Data
    let expiry: Date

    var isExpired: Bool {
        Date() >= expiry
    }
}
