//
//  MemoryCacheStore.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import Foundation

final class MemoryCacheStore: CacheStore {

    private let cache = NSCache<NSString, CacheContainer>()


    func getData(key: String) -> Data? {

        guard let item = cache.object(forKey: key as NSString) else { return nil }

        if item.value.isExpired {
            removeData(for: key)
            return nil
        }

        return item.value.data
    }


    func setData(data: Data, key: String, ttl: TimeInterval) {

        let item = CachedItem(
            data: data,
            expiry: Date().addingTimeInterval(ttl)
        )

        cache.setObject(CacheContainer(item), forKey: key as NSString)
    }

    func removeData(for key: String) {
        cache.removeObject(forKey: key as NSString)
    }

    func removeAll() {
        cache.removeAllObjects()
    }
}
