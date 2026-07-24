//
//  GetImageUseCase.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import Foundation
import Combine

class GetImageUseCase {
    
    private let imageLoader: IImageLoader
    
    init(imageLoader: IImageLoader) {
        self.imageLoader = imageLoader
    }
    
    func getImage(from urlString: String) -> AnyPublisher<Data?, ImageError> {
        imageLoader.load(urlString: urlString)
    }
}
