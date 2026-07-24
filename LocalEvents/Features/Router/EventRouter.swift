//
//  EventRouter.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import Foundation
import SwiftUI

@Observable
class EventRouter {
    var path = NavigationPath()
    
    func navigateToHome() {
        path = NavigationPath()
    }
    
    func navigateToDetail(event: LocalEvent) {
        path.append(EventRoute.event(event))
    }
}
