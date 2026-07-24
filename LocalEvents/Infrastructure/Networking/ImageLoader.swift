//
//  ImageLoader.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import Foundation
import Combine

final class ImageLoader: IImageLoader {
    
    private let session: NetworkSession
    private let diskCache: ImageCache

    init(session: NetworkSession, diskCache: ImageCache) {
        self.session = session
        self.diskCache = diskCache
    }

    func load(urlString url: String) -> AnyPublisher<Data?, ImageError> {
        guard let url = URL(string: url) else {
            return Fail(error: .invalidURL)
            .eraseToAnyPublisher()
        }

        if let data = diskCache.data(for: url) {
            return Just(data)
                .setFailureType(to: ImageError.self)
                .eraseToAnyPublisher()
        }

        let request = URLRequest(url: url)
        return session
            .dataTaskPublisher(for: request)
            .map{ [weak self] in
                self?.diskCache.add(data: $0.data, for: url)
                return $0.data
            }
            .mapError { _ in .downloadFailed }
            .eraseToAnyPublisher()
    }
}
