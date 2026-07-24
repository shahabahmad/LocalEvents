//
//  AppFactory.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import Foundation

class AppFactory: AppFactoryProtocol {

    
//    private var networkSession: NetworkSession {
//        URLNetworkSession(session: URLSession.shared)
//    }
//    
    private var networkSession: NetworkSession {
        MockNetworkSession()
    }
    
    private var networkClient: INetworkClient {
        NetworkClient(session: networkSession)
    }
    
    private var eventRepository: IEventsRepository {
        EventsRepository(networkClient: networkClient)
    }
    
    private var getNearByEventsUseCase: GetNearbyEventsUseCase {
        GetNearbyEventsUseCase(repository: eventRepository)
    }
    
    private var eventsViewModelUseCaseProvider: EventsViewModelUseCaseProvider {
        EventsViewModelUseCaseProvider(
            getNearbyEventsUseCase: getNearByEventsUseCase
        )
    }
    
    func eventsViewModel() -> EventsViewModel {
        EventsViewModel(eventsViewModelUseCaseProvider: eventsViewModelUseCaseProvider)
    }
    
}
