//
//  Data+ext.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import Foundation
import CryptoKit

extension Data {

    func sha256() -> String {
        SHA256
            .hash(data: self)
            .map {String(format: "%02x", $0)}
            .joined()
    }
}
