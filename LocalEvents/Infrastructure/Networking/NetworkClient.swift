//
//  NetworkClient.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import Foundation
import Combine

final class NetworkClient: INetworkClient {
    
    private let session: NetworkSession
    private let cache: CacheStore

    init(session: NetworkSession, cache: CacheStore) {
        self.session = session
        self.cache = cache
    }
    
    func makeApiRequest<T: Decodable>(request: NetworkRequest) -> AnyPublisher<T, NetworkError> {
        guard let request = request.urlRequest else {
            return Fail(error: .badUrl).eraseToAnyPublisher()
        }
        
        let key = request.url!.absoluteString
        if let data = cache.getData(key: key) {
            return Just(data)
                .decode(type: T.self, decoder: JSONDecoder())
                .mapError { .decodingError($0) }
                .eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: request)
            .mapError{ _ in NetworkError.badUrl}
            .tryMap { [weak self] data, response in
                guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                    throw NetworkError.invalidResponse
                }
                if data.count == 0 {
                    throw NetworkError.noData
                }
                self?.cache.setData(data: data, key: key, ttl: 600)
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError{ error in
                NetworkError.decodingError(error)
            }
            .eraseToAnyPublisher()
    }
}
