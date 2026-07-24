//
//  GetBookmarksUseCase.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import Foundation
import Combine

class GetBookmarksUseCase {
    
    private let repository: IBookmarkRepository
    
    init(repository: IBookmarkRepository) {
        self.repository = repository
    }
    
    func getBookmarks() -> AnyPublisher<[LocalEvent], RepositoryError> {
        self.repository.getBookmarkedEvents()
    }
}
