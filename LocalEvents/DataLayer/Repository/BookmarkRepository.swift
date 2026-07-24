//
//  BookmarkRepository.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import Foundation
import Combine
import CoreData

class BookmarkRepository: IBookmarkRepository {
    
    private let bookmarkStore: IBookmarkStore

    init(bookmarkStore: IBookmarkStore) {
        self.bookmarkStore = bookmarkStore
    }
    
    func addBookmark(event: LocalEvent) -> AnyPublisher<Void, RepositoryError> {

        bookmarkStore
            .addBookmark(eventId: event.id)
            .mapError { _ in RepositoryError.unknown }
            .eraseToAnyPublisher()
    }
    
    func removeBookmark(event: LocalEvent) -> AnyPublisher<Void, RepositoryError> {

        bookmarkStore
            .removeBookmark(eventId: event.id)
            .mapError { _ in RepositoryError.unknown }
            .eraseToAnyPublisher()
    }
    
    func getBookmarkedEvents() -> AnyPublisher<[LocalEvent], RepositoryError> {
        bookmarkStore
            .getBookmarkedEvents()
            .mapError { _ in RepositoryError.unknown }
            .eraseToAnyPublisher()
    }
}
