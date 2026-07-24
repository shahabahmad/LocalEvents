//
//  GetNearbyEventsUseCase.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import Foundation
import Combine

class GetNearbyEventsUseCase {
    
    private let repository: IEventsRepository
    
    init(repository: IEventsRepository) {
        self.repository = repository
    }
    
    func getNearbyEvents(location: Coordinate?) -> AnyPublisher<[LocalEvent], RepositoryError> {
        
        self.repository.getEvents(location: location)
    }
}

