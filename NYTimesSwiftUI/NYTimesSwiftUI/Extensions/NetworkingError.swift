//
//  NetworkingError.swift
//  NYTimesSwiftUI
//
//  Created by ali alhawas on 25/10/1445 AH.
//

import Foundation

// MARK: Error
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

// MARK: Networking Error handleResponse
extension NetworkingError {
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
extension NetworkingError: Equatable {
    static func == (lhs: NetworkingError, rhs: NetworkingError) -> Bool {
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
