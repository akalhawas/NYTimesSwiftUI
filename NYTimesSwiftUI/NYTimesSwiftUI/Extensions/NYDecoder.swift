//
//  NYDecoder.swift
//  NYTimesSwiftUI
//
//  Created by ali alhawas on 28/10/1445 AH.
//

import Foundation

struct NYDecoder {
    /// Get local file and decode it
    /// - Parameters:
    ///   - data: Data
    ///   - type: T.Type
    /// - Returns: T
    /// - Note: throws
    static func decode<T: Decodable>(data: Data, type: T.Type) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            Log.error("\(NetworkingError.failedToDecode)")
            throw NetworkingError.failedToDecode
        }
    }
}
