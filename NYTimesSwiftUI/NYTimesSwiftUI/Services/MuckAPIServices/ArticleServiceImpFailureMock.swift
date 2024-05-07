//
//  ArticleServiceImpFailureMock.swift
//  NYTimesSwiftUI
//
//  Created by ali alhawas on 25/10/1445 AH.
//

import Foundation

final class ArticleServiceImpFailureMock: ArticleAPIService {
    /// Semulate throwing error case
    /// - Returns: [ArticleModel]
    /// - Note: async throws
    func fetchArticle() async throws -> [ArticleModel] {
        let response = try NYLocalFileDecoder.decode(file: "", type: ArticleResponse.self)
        return response.results
    }
}
