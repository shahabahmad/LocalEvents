//
//  ImageCache.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import Foundation
import UIKit

protocol ImageCache {

    func data(for url: URL) -> Data?

    func add(data: Data, for url: URL)

    func remove(for url: URL)

    func removeAll()
}
