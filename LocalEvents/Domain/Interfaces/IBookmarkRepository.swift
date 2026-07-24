//
//  IBookmarkRepository.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import Foundation
import Combine

protocol IBookmarkRepository {
    
    func getBookmarkedEvents() -> AnyPublisher<[LocalEvent], RepositoryError>
    
    func addBookmark(event: LocalEvent) -> AnyPublisher<Void, RepositoryError>
    
    func removeBookmark(event: LocalEvent) -> AnyPublisher<Void, RepositoryError>
}
