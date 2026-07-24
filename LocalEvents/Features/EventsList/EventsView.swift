//
//  EventsView.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import SwiftUI

struct EventsView: View {

    @State var eventsViewModel: EventsViewModel
    @Environment(EventRouter.self) var router: EventRouter

    init(eventsViewModel: EventsViewModel) {
        self.eventsViewModel = eventsViewModel
    }

    var body: some View {
        List($eventsViewModel.events) { $event in
            EventChildView(event: event, coordinate: eventsViewModel.location) {
                eventsViewModel.toggleBookMark(for: event)
            }
                .onTapGesture {
                    router.navigateToDetail(event: event)
                }
        }
        .listStyle(.plain)
        .onAppear {
            self.eventsViewModel.onAppear()
        }
    }
}

#Preview {
    let eventsViewModel = AppFactory().eventsViewModel
    EventsView(eventsViewModel: eventsViewModel)
}
