//
//  IEventsRepository.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import Foundation
import Combine

protocol IEventsRepository {
    func getEvents(page: Int,
                   location: Coordinate) -> AnyPublisher<[LocalEvent], RepositoryError>
}
