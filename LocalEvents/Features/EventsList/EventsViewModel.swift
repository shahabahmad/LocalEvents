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
    private let locationService: ILocationService
    private let mapsService: IMapsService

    init(eventsViewModelUseCaseProvider: EventsViewModelUseCaseProvider, locationService: ILocationService, mapsService: IMapsService) {
        self.eventsViewModelUseCaseProvider = eventsViewModelUseCaseProvider
        self.locationService = locationService
        self.mapsService = mapsService
        observeLocation()
    }
    
    func observeLocation() {
        locationService
            .locationPublisher
            .removeDuplicates()
            .sink { [weak self] coordinate in
                self?.location = coordinate
                self?.fetchEvents()
            }
            .store(in: &cancellables)
    }
    
    func onAppear() {
        locationService.requestPermission()
        locationService.startUpdatingLocation()
        fetchEvents()
    }
    
    func openMap(for event: LocalEvent) {
        self.mapsService.openMap(
            coordinate: event.location,
            name: event.title
        )
    }
    
    func fetchEvents() {
        if isLoading {
            return
        }
        
        isLoading = true
        self.eventsViewModelUseCaseProvider
            .getNearbyEventsUseCase
            .getNearbyEvents(location: location)
        .receive(on: RunLoop.main)
        .sink {[weak self] completed in
            self?.isLoading = false
            switch completed {
            case .finished:
                break
            case .failure(let error):
                self?.error = error
            }
        } receiveValue: { [weak self] response in
            self?.events.append(contentsOf: response)
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
