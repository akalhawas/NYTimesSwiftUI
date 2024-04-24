//
//  NetworkManager.swift
//  NYTimesSwiftUI
//
//  Created by ali alhawas on 14/10/1445 AH.
//

import Foundation
import Combine

class NetworkingManager:ObservableObject {

    static func download(url: URL) -> AnyPublisher<Data,Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({ try handleURLResponse(output: $0)})
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse, (200...300) ~= response.statusCode else {
            let statusCode = (output.response as! HTTPURLResponse).statusCode
            Log.statusCode(statusCode)
            Log.error("\(NetworkingError.invalidStatusCode(statusCode: statusCode).localizedDescription)")
            throw NetworkingError.invalidStatusCode(statusCode: statusCode)
        }
        return output.data
    }
}

extension NetworkingManager {
    enum NetworkingError: LocalizedError {
        case invalidUrl
        case custom(error: Error)
        case invalidStatusCode(statusCode: Int)
        case invalidData
        case failedToDecode
    }
}

// MARK: Networking Error
extension NetworkingManager.NetworkingError {
    var errorDescription: String? {
        switch self {
            case .invalidUrl: return "URL isn't valid"
            case .invalidStatusCode(let code): return handleResponse(code)
            case .invalidData: return "Response data is invalid"
            case .failedToDecode: return "Failed to decode"
            case .custom(let err): return "Something went wrong \(err.localizedDescription)"
        }
    }
    
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
