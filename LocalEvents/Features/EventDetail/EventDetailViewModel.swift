//
//  EventDetailViewModel.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import Foundation
import UIKit
import Combine

@Observable
class EventDetailViewModel {
    
    let event: LocalEvent
    var image: UIImage?
    private let getImageUseCase: GetImageUseCase
    
    var isLoading: Bool = false
    var cancellables: Set<AnyCancellable> = []
    
    init(event: LocalEvent, getImageUseCase: GetImageUseCase) {
        self.event = event
        self.getImageUseCase = getImageUseCase
    }
    
    func loadImage() {
        guard let urlString = self.event.imageURLString else { return }
        self.getImageUseCase.getImage(from: urlString)
            .sink { finished in
                print("completed")
            } receiveValue: {[weak self] data in
                if let data = data {
                    self?.image = UIImage(data: data)
                }
            }
            .store(in: &cancellables)
    }
    
    func getTimeString() -> String {
        return event.time.formatted(
            .dateTime
                .year()
                .month(.abbreviated)
                .day()
                .hour()
                .minute()
        )
    }
}
