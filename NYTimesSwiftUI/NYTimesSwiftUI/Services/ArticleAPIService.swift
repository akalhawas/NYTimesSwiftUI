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
        do {
            let data = try await NetworkingManager.download(url: url)
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let response = try decoder.decode(ArticleResponse.self, from: data)
                let articles = response.results
                return articles
            } catch {
                Log.error("\(NetworkingError.failedToDecode)")
                throw NetworkingError.failedToDecode
            }
        } catch {
            throw error
        }
    }
}
