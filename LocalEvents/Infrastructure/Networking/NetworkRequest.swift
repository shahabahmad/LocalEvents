//
//  NetworkRequest.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import Foundation

struct NetworkRequest {
    let endpoint: Endpoint
    let method: NetworkMethodType
    let body: Encodable?
    let headers: [String: String]?
    
    init(endpoint: Endpoint,
         method: NetworkMethodType,
         body: Encodable? = nil,
         headers: [String : String]? = nil) {
        self.endpoint = endpoint
        self.method = method
        self.body = body
        self.headers = headers
    }
    
    var urlRequest: URLRequest?  {
        guard let url = endpoint.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        if let body = body, method == .post {
            request.httpBody = try? JSONEncoder().encode(body)
        }
        for (key, value) in headers ?? [:] {
            request.setValue(value, forHTTPHeaderField: key)
        }
        return request
    }
}
