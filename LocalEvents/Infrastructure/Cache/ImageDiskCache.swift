//
//  ImageDiskCache.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import Foundation

final class ImageDiskCache: ImageCache {

    private let fileManager: FileManager
    private let directory: URL

    init(fileManager: FileManager = .default) {

        self.fileManager = fileManager

        let cachesDirectory =
            fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]

        self.directory =
            cachesDirectory
                .appendingPathComponent("ImageCache", isDirectory: true)

        createDirectoryIfNeeded()
    }


    func data(for url: URL) -> Data? {
        let fileURL = fileURL(for: url)
        return try? Data(
            contentsOf: fileURL
        )
    }


    func add(data: Data, for url: URL) {
        let fileURL = fileURL(for: url)
        do {
            try data.write(to: fileURL, options: [.atomic])
        } catch {
            print("Image cache write failed:", error)
        }
    }

    func remove(for url: URL) {
        let fileURL = fileURL(for: url)
        try? fileManager.removeItem(at: fileURL)
    }


    func removeAll() {
        try? fileManager.removeItem(at: directory)
        createDirectoryIfNeeded()
    }
}

private extension ImageDiskCache {

    func createDirectoryIfNeeded() {
        guard !fileManager.fileExists(atPath: directory.path) else { return }
        try? fileManager.createDirectory(at: directory, withIntermediateDirectories: true)
    }

    func fileURL(for url: URL) -> URL {

        let filename = url.absoluteString.data(using: .utf8)!.sha256()
        return directory.appendingPathComponent(filename)
    }
}
