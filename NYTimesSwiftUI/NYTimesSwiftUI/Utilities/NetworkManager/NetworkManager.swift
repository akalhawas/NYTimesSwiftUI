//
//  NetworkManager.swift
//  NYTimesSwiftUI
//
//  Created by ali alhawas on 14/10/1445 AH.
//

import Foundation
import Combine

class NetworkingManager:ObservableObject {

    /// Processing URL session data task results with Combine
    /// - Parameter url: URL
    /// - Returns: AnyPublisher<Data,Error>
    static func download(url: URL) -> AnyPublisher<Data,Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .timeout(.seconds(8), scheduler: DispatchQueue.main)
            .tryMap(handleURLResponse)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    /// Handle URL response returns Data -> throws error if bad response
    /// - Parameter output: URLSession.DataTaskPublisher.Output
    /// - Returns: Data
    /// - Note: Throws error if bad response
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse, (200...300) ~= response.statusCode else {
            let statusCode = (output.response as! HTTPURLResponse).statusCode
            #if DEV
            Log.error("\(NetworkingError.invalidStatusCode(statusCode: statusCode).localizedDescription)")
            #endif
            throw NetworkingError.invalidStatusCode(statusCode: statusCode)
        }
        return output.data
    }
}

// MARK: Networking Error
extension NetworkingManager {
    enum NetworkingError: LocalizedError {
        case invalidUrl
        case custom(error: Error)
        case invalidStatusCode(statusCode: Int)
        case invalidData
        case failedToDecode
        
        var errorDescription: String? {
            switch self {
                case .invalidUrl: return "URL isn't valid"
                case .invalidStatusCode(let code): return handleResponse(code)
                case .invalidData: return "Response data is invalid"
                case .failedToDecode: return "Failed to decode"
                case .custom(let err): return "Something went wrong \(err.localizedDescription)"
            }
        }
    }
}

// MARK: Networking Error handleResponse
extension NetworkingManager.NetworkingError {
    /// Parses a HTTP StatusCode and returns a proper error
    /// - Parameter statusCode: HTTP status code
    /// - Returns: String
    private func handleResponse(_ statusCode: Int) -> String {
        switch statusCode {
            case 400: return "Bad Request"
            case 401: return "Unauthorized"
            case 403: return "Forbidden"
            case 404: return "Not Found"
            case 429: return "You have exceeded the rate limit"
            case 500: return "Server Error"
            default: return "Unknown Error"
        }
    }
}

// MARK: Networking Error Equatable
extension NetworkingManager.NetworkingError: Equatable {
    static func == (lhs: NetworkingManager.NetworkingError, rhs: NetworkingManager.NetworkingError) -> Bool {
        switch(lhs, rhs) {
            case (.invalidUrl, .invalidUrl):
                return true
            case (.custom(let lhsType), .custom(let rhsType)):
                return lhsType.localizedDescription == rhsType.localizedDescription
            case (.invalidStatusCode(let lhsType), .invalidStatusCode(let rhsType)):
                return lhsType == rhsType
            case (.invalidData, .invalidData):
                return true
            case (.failedToDecode, .failedToDecode):
                return true
            default:
                return false
        }
    }
}
