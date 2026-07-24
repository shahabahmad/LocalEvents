//
//  EventsViewModelUseCaseProvider.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import Foundation

struct EventsViewModelUseCaseProvider {
    let getNearbyEventsUseCase: GetNearbyEventsUseCase
    let getBookmarksUseCase: GetBookmarksUseCase
    let addBookmarkUseCase: AddBookmarkUseCase
    let removeBookmarkUseCase: RemoveBookmarkUseCase
}
