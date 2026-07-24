//
//  LocalEventsApp.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import SwiftUI
import CoreData

@main
struct LocalEventsApp: App {
    let persistenceController = PersistenceController.shared
    let eventRouter = EventRouter()
    let appfactory = AppFactory()
    
    var body: some Scene {
        WindowGroup {
            EventFlow(router: eventRouter, appFactory: appfactory)
                .environment(\.managedObjectContext,
                              persistenceController
                    .container
                    .viewContext
                )
        }
    }
}
