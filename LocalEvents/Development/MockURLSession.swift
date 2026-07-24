//
//  MockURLSession.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import Foundation
import Combine

final class MockNetworkSession: NetworkSession {

    func dataTaskPublisher(
        for request: URLRequest
    ) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {

        guard let url = Bundle.main.url(
            forResource: "Events",
            withExtension: "json"
        ) else {

            return Fail(
                error: URLError(.fileDoesNotExist)
            )
            .eraseToAnyPublisher()
        }


        do {
            let data = try Data(contentsOf: url)

            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!

            return Just((data, response))
                .setFailureType(to: URLError.self)
                .eraseToAnyPublisher()

        } catch {

            return Fail(
                error: URLError(.cannotDecodeContentData)
            )
            .eraseToAnyPublisher()
        }
    }
}
