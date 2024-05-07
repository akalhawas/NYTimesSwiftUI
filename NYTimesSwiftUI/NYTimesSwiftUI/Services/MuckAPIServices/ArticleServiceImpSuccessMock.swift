//
//  ArticleServiceImpSuccessMock.swift
//  NYTimesSwiftUI
//
//  Created by ali alhawas on 25/10/1445 AH.
//

import Foundation

final class ArticleServiceImpSuccessMock: ArticleAPIService {
    /// Semulate fetching articles using muck data from local json file
    /// - Returns: [ArticleModel]
    /// - Note: async throws
    func fetchArticle() async throws -> [ArticleModel] {
        let response = try NYLocalFileDecoder.decode(file: "ArticleData", type: ArticleResponse.self)
        return response.results
    }
}
