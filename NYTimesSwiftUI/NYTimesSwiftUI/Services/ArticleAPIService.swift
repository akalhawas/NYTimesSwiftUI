//
//  ArticleAPIService.swift
//  NYTimesSwiftUI
//
//  Created by ali alhawas on 25/10/1445 AH.
//

import Foundation

// MARK: Abstrtaction
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
