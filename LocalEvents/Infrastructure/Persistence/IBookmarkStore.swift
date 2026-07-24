//
//  IBookmarkStore.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import Foundation
import Combine

protocol IBookmarkStore {

    func addBookmark(eventId: Int)
        -> AnyPublisher<Void, DBError>

    func removeBookmark(eventId: Int)
        -> AnyPublisher<Void, DBError>

    func getBookmarkedEvents()
        -> AnyPublisher<[LocalEvent], DBError>
}
