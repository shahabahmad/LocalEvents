//
//  URLNetworkSession.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import Foundation
import Combine

final class URLNetworkSession: NetworkSession {

    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func dataTaskPublisher(
        for request: URLRequest
    ) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {

        session
            .dataTaskPublisher(for: request)
            .eraseToAnyPublisher()
    }
}
