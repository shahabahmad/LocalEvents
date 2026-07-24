//
//  RemoveBookmarkUseCase.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import Foundation
import Combine

class RemoveBookmarkUseCase {
    private let repository: IBookmarkRepository
    
    init(repository: IBookmarkRepository) {
        self.repository = repository
    }
    
    func removeBookmark(event: LocalEvent) -> AnyPublisher<Void, RepositoryError> {
        self.repository.removeBookmark(event: event)
    }
}
