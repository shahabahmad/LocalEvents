//
//  IImageLoader.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import Foundation
import Combine

protocol IImageLoader {
    func load(urlString: String) -> AnyPublisher<Data?, ImageError>
}
