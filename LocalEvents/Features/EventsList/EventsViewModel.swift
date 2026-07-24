//
//  EventsViewModel.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import Foundation
import Combine

@Observable
class EventsViewModel {
    
    var events: [LocalEvent] = []
    
    var error: Error?
    
    private let eventsViewModelUseCaseProvider: EventsViewModelUseCaseProvider
    
    private var cancellables: Set<AnyCancellable> = []

    var isLoading = false
    
    var location: Coordinate?
    
    init(eventsViewModelUseCaseProvider: EventsViewModelUseCaseProvider) {
        self.eventsViewModelUseCaseProvider = eventsViewModelUseCaseProvider
    }
    
    func fetchEvents() {
        if isLoading {
            return
        }
        let location = Coordinate(latitude: 12.11, longitude: 31.456)
//        guard let location = location else { return }
        
        self.eventsViewModelUseCaseProvider
            .getNearbyEventsUseCase
            .getNearbyEvents(location: location)
        .receive(on: RunLoop.main)
        .sink { completed in
            switch completed {
            case .finished:
                break
            case .failure(let error):
                self.error = error
            }
        } receiveValue: { response in
            self.events.append(contentsOf: response)
        }
        .store(in: &cancellables)

    }
    
    func addBookmark(for index: Int) {
        self.eventsViewModelUseCaseProvider.addBookmarkUseCase.addBookmark(event: events[index])
            .sink { [weak self] completed in
                switch completed {
                    case .finished:
                    break
                case .failure(let error):
                    self?.error = error
                    self?.events[index].isBookMarked.toggle()
                }
            } receiveValue: { _ in
                
            }
            .store(in: &cancellables)
    }
    
    func removeBookmark(for index: Int) {
        self.eventsViewModelUseCaseProvider.removeBookmarkUseCase.removeBookmark(event: events[index])
            .sink { [weak self] completed in
                switch completed {
                    case .finished:
                    break
                case .failure(let error):
                    self?.error = error
                    self?.events[index].isBookMarked.toggle()
                }
            } receiveValue: { _ in
                
            }
            .store(in: &cancellables)
    }
    
    func toggleBookMark(for event: LocalEvent) {
        guard let index = events.firstIndex(of: event) else { return }
        events[index].isBookMarked.toggle()
        if events[index].isBookMarked {
            addBookmark(for: index)
        } else {
            removeBookmark(for: index)
        }
    }
    
    func getAllBookmarkedEvents() {

    }
}
