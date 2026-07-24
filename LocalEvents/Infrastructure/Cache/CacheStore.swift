//
//  CacheStore.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import Foundation

protocol CacheStore {
    
    func getData(key: String) -> Data?

    func setData(data: Data, key: String, ttl: TimeInterval)

    func removeData(for key: String)

    func removeAll()
}
