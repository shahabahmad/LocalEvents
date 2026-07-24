//
//  BookmarkStore.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import Foundation
import CoreData
import Combine

final class BookmarkStore: IBookmarkStore {

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }


    func addBookmark(eventId: Int) -> AnyPublisher<Void, DBError> {

        Future { [weak self] promise in
            guard let self else {
                promise(.failure(.other))
                return
            }
            self.context.perform {
                do {
                    let request: NSFetchRequest<EventEntity> = EventEntity.fetchRequest()
                    request.fetchLimit = 1
                    request.predicate = NSPredicate(format: "id == %d", eventId)
                    guard let eventEntity = try self.context.fetch(request).first else {
                        promise(.failure(.other))
                        return
                    }

                    if eventEntity.bookmark != nil {
                        promise(.success(()))
                        return
                    }

                    let bookmarkEntity = BookmarkEntity(context: self.context)
                    bookmarkEntity.event = eventEntity
                    try self.context.save()
                    promise(.success(()))
                } catch {
                    promise(.failure(.saveFailed(error)))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func removeBookmark(eventId: Int) -> AnyPublisher<Void, DBError> {

        Future { [weak self] promise in
            guard let self else {
                promise(.failure(.other))
                return
            }
            self.context.perform {
                do {
                    let request: NSFetchRequest<EventEntity> = EventEntity.fetchRequest()
                    request.fetchLimit = 1
                    request.predicate = NSPredicate(format: "id == %d", eventId)
                    guard let eventEntity = try self.context.fetch(request).first else {
                        promise(.failure(.other))
                        return
                    }
                    guard let bookmarkEntity = eventEntity.bookmark else {
                        promise(.failure(.other))
                        return
                    }
                    self.context.delete(bookmarkEntity)
                    try self.context.save()
                    promise(.success(()))
                } catch {
                    promise(.failure(.saveFailed(error)))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func getBookmarkedEvents() -> AnyPublisher<[LocalEvent], DBError> {

        Future { [weak self] promise in
            guard let self else { return }
            self.context.perform {
                do {
                    let request: NSFetchRequest<BookmarkEntity> =
                        BookmarkEntity.fetchRequest()

                    let bookmarks = try self.context.fetch(request)
                    let events = bookmarks.compactMap { $0.event?.toDomain() }
                    promise(.success(events))

                } catch {
                    promise(.failure(.fetchFailed(error)))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
