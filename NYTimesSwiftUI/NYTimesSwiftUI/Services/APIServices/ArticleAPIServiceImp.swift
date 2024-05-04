//
//  ArticleAPIServiceImp.swift
//  NYTimesSwiftUI
//
//  Created by ali alhawas on 15/10/1445 AH.
//

import Foundation

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
                throw NetworkingError.failedToDecode
            }
        } catch {
            throw error
        }
    }
}
