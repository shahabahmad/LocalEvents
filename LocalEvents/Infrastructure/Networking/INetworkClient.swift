//
//  INetworkClient.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import Foundation
import Combine

protocol INetworkClient {
        
    func makeApiRequest<T: Decodable>(request: NetworkRequest) -> AnyPublisher<T, NetworkError>
}
