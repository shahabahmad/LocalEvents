//
//  AppFactory.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import Foundation

class AppFactory: AppFactoryProtocol {

    
    lazy private var urlNetworkSession: NetworkSession = {
        URLNetworkSession(session: URLSession.shared)
    }()

    lazy var imageCache: ImageCache = {
        ImageDiskCache()
    }()
    
    lazy var imageLoader: IImageLoader = {
        ImageLoader(session: urlNetworkSession, diskCache: imageCache)
    }()
    
    private lazy var networkCache: CacheStore = {
        MemoryCacheStore()
    }()
    
    private lazy var persistenceController: PersistenceController = {
        PersistenceController.shared
    }()
    
    private lazy var networkSession: NetworkSession = {
        MockNetworkSession()
    }()
    
    private lazy var networkClient: INetworkClient = {
        NetworkClient(session: networkSession, cache: networkCache)
    }()
    
    private var eventStore: IEventStore {
        EventStore(context: persistenceController.viewContext)
    }
    
    private var eventRepository: IEventsRepository {
        EventsRepository(networkClient: networkClient, eventStore: eventStore)
    }

    
    private var getNearByEventsUseCase: GetNearbyEventsUseCase {
        GetNearbyEventsUseCase(repository: eventRepository)
    }
    
    private var bookmarkStore: IBookmarkStore {
        BookmarkStore(context: persistenceController.viewContext)
    }
    
    private var bookmarkRepository: IBookmarkRepository {
        BookmarkRepository(bookmarkStore: bookmarkStore)
    }
    
    private var getBookmarksUseCase: GetBookmarksUseCase {
        GetBookmarksUseCase(repository: bookmarkRepository)
    }
    
    private var addBookmarkUseCase: AddBookmarkUseCase {
        AddBookmarkUseCase(repository: bookmarkRepository)
    }
    
    private var removeBookmarkUseCase: RemoveBookmarkUseCase {
        RemoveBookmarkUseCase(repository: bookmarkRepository)
    }
    
    private var eventsViewModelUseCaseProvider: EventsViewModelUseCaseProvider {
        EventsViewModelUseCaseProvider(
            getNearbyEventsUseCase: getNearByEventsUseCase,
            getBookmarksUseCase: getBookmarksUseCase,
            addBookmarkUseCase: addBookmarkUseCase,
            removeBookmarkUseCase: removeBookmarkUseCase
        )
    }
    
    func eventsViewModel() -> EventsViewModel {
        EventsViewModel(eventsViewModelUseCaseProvider: eventsViewModelUseCaseProvider)
    }
    
    private var getImageUseCase: GetImageUseCase {
        GetImageUseCase(imageLoader: imageLoader)
    }
    
    func eventDetailViewModel(event: LocalEvent) -> EventDetailViewModel {
        EventDetailViewModel(event: event, getImageUseCase: getImageUseCase)
    }
    
}
