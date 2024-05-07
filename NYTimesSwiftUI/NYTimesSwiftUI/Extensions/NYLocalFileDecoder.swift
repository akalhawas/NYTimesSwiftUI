//
//  StaticJSONMapper.swift
//  NYTimesSwiftUI
//
//  Created by ali alhawas on 25/10/1445 AH.
//

import Foundation

struct NYLocalFileDecoder {
    /// Get local file and decode it
    /// - Parameters:
    ///   - file: String
    ///   - type: T.Type
    /// - Returns: T
    /// - Note: throws
    static func decode<T: Decodable>(file: String, type: T.Type) throws -> T {
        
        guard !file.isEmpty,
              let path = Bundle.main.path(forResource: file, ofType: "json"),
              let data = FileManager.default.contents(atPath: path) else {
            throw NetworkingError.failedToDecode
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(T.self, from: data)
    }
}
