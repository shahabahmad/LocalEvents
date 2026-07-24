//
//  AddBookmarkUseCase.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import Foundation
import Combine

class AddBookmarkUseCase {
    
    private let repository: IBookmarkRepository
    
    init(repository: IBookmarkRepository) {
        self.repository = repository
    }
    
    func addBookmark(event: LocalEvent) -> AnyPublisher<Void, RepositoryError> {
        self.repository.bookmark(event: event)
    }
}
