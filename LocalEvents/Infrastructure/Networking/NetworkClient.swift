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
    
    init(session: NetworkSession) {
        self.session = session
    }
    
    func makeApiRequest<T: Decodable>(request: NetworkRequest) -> AnyPublisher<T, NetworkError> {
        guard let request = request.urlRequest else {
            return Fail(error: .badUrl).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: request)
            .mapError{ _ in NetworkError.badUrl}
            .tryMap { data, response in
                guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                    throw NetworkError.invalidResponse
                }
                if data.count == 0 {
                    throw NetworkError.noData
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError{ error in
                NetworkError.decodingError(error)
            }
            .eraseToAnyPublisher()
    }
}
