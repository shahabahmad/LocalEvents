//
//  EventsRepository.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import Foundation
import Combine

class EventsRepository: IEventsRepository {
    
    private let networkClient: INetworkClient
        
    init(networkClient: INetworkClient) {
        self.networkClient = networkClient
    }
    
    func getEvents(location: Coordinate) -> AnyPublisher<[LocalEvent], RepositoryError> {
                
        let request = NetworkRequest(endpoint: .getEvents(location),
                                     method: .get)
        return networkClient.makeApiRequest(request: request)
            .map { (response: [EventDto]) in
                response.compactMap {
                    try? $0.toDomain()
                }
            }
            .mapError { error in
                switch error {
                case .badUrl,
                     .invalidResponse:
                    return RepositoryError.unavailable

                case .noData:
                    return .dataUnavailable

                case .decodingError:
                    return RepositoryError.unknown
                }
            }
            .eraseToAnyPublisher()
    }
    
}
