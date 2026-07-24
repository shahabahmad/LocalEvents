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
    private let eventStore: IEventStore

    init(networkClient: INetworkClient, eventStore: IEventStore) {
        self.networkClient = networkClient
        self.eventStore = eventStore
    }
    
    func fetchLocalEvents() -> AnyPublisher<[LocalEvent], RepositoryError> {
        return eventStore.allEvents()
            .mapError({ _ in RepositoryError.unknown })
            .eraseToAnyPublisher()
    }
    
    func getEvents(location: Coordinate) -> AnyPublisher<[LocalEvent], RepositoryError> {
                
        let request = NetworkRequest(endpoint: .getEvents(location),
                                     method: .get)
        
        return networkClient
            .makeApiRequest(request: request)
            .map { (response: [EventDto]) in
                response.compactMap {
                    try? $0.toDomain()
                }
            }
            .mapError({ error in
                switch error {
                case .badUrl,
                     .invalidResponse:
                    return RepositoryError.unavailable

                case .noData:
                    return .dataUnavailable

                case .decodingError:
                    return RepositoryError.unknown
                }
            })
            .flatMap { [weak self] events -> AnyPublisher<[LocalEvent], RepositoryError> in

                guard let self else {
                    return Fail(error: .unknown)
                        .eraseToAnyPublisher()
                }

                return self.eventStore
                    .syncEvents(events: events)
                    .mapError {_ in
                        .unknown
                    }
                    .eraseToAnyPublisher()
            }
            .catch { [weak self] error -> AnyPublisher<[LocalEvent], RepositoryError> in
                guard let self else {
                    return Fail(error: .unknown)
                        .eraseToAnyPublisher()
                }
                return self.eventStore
                    .allEvents()
                    .mapError {_ in
                        .unknown
                    }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
