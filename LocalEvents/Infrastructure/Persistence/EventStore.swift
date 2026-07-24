//
//  EventStore.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import Foundation
import CoreData
import Combine

final class EventStore: IEventStore {

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func fetchAllEvents() throws -> [EventEntity] {
        let request: NSFetchRequest<EventEntity> = EventEntity.fetchRequest()
        return try context.fetch(request)
    }
    
    func allEvents() -> AnyPublisher<[LocalEvent], DBError> {
        Future { [weak self] promise in
            guard let self else {
                promise(.failure(.other))
                return
            }
            self.context.perform {
                do {
                    let request: NSFetchRequest<EventEntity> =
                        EventEntity.fetchRequest()
                    let eventEntities = try self.context.fetch(request)
                    let events = eventEntities.map {
                        $0.toDomain()
                    }
                    promise(.success(events))
                } catch {
                    promise(.failure(.fetchFailed(error)))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func syncEvents(events: [LocalEvent]) -> AnyPublisher<Void, DBError> {
        Future { [weak self] promise in
            guard let self else {
                promise(.failure(.other))
                return
            }

            self.context.perform {
                do {
                    let existingEvents = try self.fetchAllEvents()
                    let existingEventDictionary =
                    Dictionary(
                        uniqueKeysWithValues:
                            existingEvents.map { (Int($0.id), $0) }
                    )
                    var receivedIds = Set<Int>()
                    for event in events {
                        receivedIds.insert(event.id)
                        if let existingEntity =
                            existingEventDictionary[event.id] {
                            self.update(
                                entity: existingEntity,
                                with: event
                            )

                        } else {
                            let newEntity =
                            EventEntity(context: self.context)
                            self.update(
                                entity: newEntity,
                                with: event
                            )
                        }
                    }

                    let staleEvents =
                    existingEvents.filter { entity in

                        !receivedIds.contains(
                            Int(entity.id)
                        )
                    }
                    staleEvents.forEach {
                        self.context.delete($0)
                    }
                    try self.context.save()
                    promise(.success(()))
                } catch {
                    promise(
                        .failure(
                            .saveFailed(error)
                        )
                    )
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func update(entity: EventEntity, with event: LocalEvent ) {

        entity.id = Int64(event.id)
        entity.title = event.title

        entity.latitude =
            event.location.latitude

        entity.longitude =
            event.location.longitude

        entity.time = event.time

        entity.imageUrlString =
            event.imageURLString
    }
}
