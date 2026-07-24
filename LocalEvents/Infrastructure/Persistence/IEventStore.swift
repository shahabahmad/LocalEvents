//
//  IEventStore.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import Foundation
import Combine

protocol IEventStore {
    func allEvents() -> AnyPublisher<[LocalEvent], DBError>
    func syncEvents(events: [LocalEvent]) -> AnyPublisher<[LocalEvent], DBError>
}
