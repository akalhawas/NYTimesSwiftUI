//
//  NetworkManager.swift
//  NYTimesSwiftUI
//
//  Created by ali alhawas on 14/10/1445 AH.
//

import Foundation

final class NetworkingManager {
    /// Async function processing URL session data results with Async Await
    /// - Parameter url: URL
    /// - Returns: Data
    /// - Note: async and throws
    static func download(url: URL) async throws -> Data {
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            try handleURLResponse(response: response)
            return data
        } catch {
            throw error
        }
    }
    
    /// Handle URL response returns Data -> throws error if bad response
    /// - Parameter response: URLResponse
    /// - Note: throws
    static func handleURLResponse(response: URLResponse) throws {
        guard let response = response as? HTTPURLResponse, (200...300) ~= response.statusCode else {
            let statusCode = (response as! HTTPURLResponse).statusCode
            Log.error("\(NetworkingError.invalidStatusCode(statusCode: statusCode).localizedDescription)")
            throw NetworkingError.invalidStatusCode(statusCode: statusCode)
        }
    }
}
