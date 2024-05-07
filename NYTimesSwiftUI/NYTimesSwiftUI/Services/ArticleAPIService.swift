//
//  ArticleAPIService.swift
//  NYTimesSwiftUI
//
//  Created by ali alhawas on 25/10/1445 AH.
//

import Foundation

// MARK: Abstrtaction
// Applying the Abstraction Hide the logic
// Applying the dependency inversion Hide the logic
// Applying solid princples instead of concrate class
// Better Reusability Testability, Easier Maintenance and Modification
protocol ArticleAPIService {
    func fetchArticle() async throws -> [ArticleModel]
}

// MARK: Prosses
extension ArticleAPIService {
    /// Middle layer to process data from multiple api calls
    /// - Returns: [ArticleModel]
    /// - Note: async and throws
    func articles() async throws -> [ArticleModel] {
        let article = try await fetchArticle()
        return article
    }
}

// MARK: Implementation
final class ArticleAPIServiceImp: ArticleAPIService {
    /// Fetching Articles and decoding data to ArticleResponse
    /// - Returns: [ArticleModel]
    /// - Note: async throws
    func fetchArticle() async throws -> [ArticleModel] {
        
        let urlString = APIConstants.baseURL.appending(EndPointConstants.mostPopularArticles)
        let url = URL(string: urlString)!
        Log.info("\(url.absoluteString)", shouldLogContext: false)
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            try handleURLResponse(response: response)
            
            let articleResponse = try NYDecoder.decode(data: data, type: ArticleResponse.self)
            return articleResponse.results
        } catch {
            throw error
        }
    }
    
    /// Handle URL response returns Data -> throws error if bad response
    /// - Parameter response: URLResponse
    /// - Note: throws
    func handleURLResponse(response: URLResponse) throws {
        guard let response = response as? HTTPURLResponse, (200...300) ~= response.statusCode else {
            let statusCode = (response as! HTTPURLResponse).statusCode
            Log.error("\(NetworkingError.invalidStatusCode(statusCode: statusCode).localizedDescription)")
            throw NetworkingError.invalidStatusCode(statusCode: statusCode)
        }
        Log.info("[Status:\(response.statusCode)] Success", shouldLogContext: false)
    }
}
