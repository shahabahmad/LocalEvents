//
//  EventFlow.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import SwiftUI

struct EventFlow: View {
    
    @State var router: EventRouter
    private let appFactory: AppFactory

    init(router: EventRouter, appFactory: AppFactory) {
        self.router = router
        self.appFactory = appFactory
    }
    
    var body: some View {
        NavigationStack(path: $router.path) {
            EventsView(eventsViewModel: appFactory.eventsViewModel())
                .navigationDestination(for: EventRoute.self) { route in
                    switch route {
                    case .event(let event):
                        EmptyView()
                    }
                }
        }
        .environment(router)
    }
}

#Preview {
    let appFactory = AppFactory()
    let router = EventRouter()
    EventFlow(router: router, appFactory: appFactory)
}
