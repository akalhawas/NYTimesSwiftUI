//
//  MockArticleAPIServiceImp.swift
//  NYTimesSwiftUI
//
//  Created by ali alhawas on 15/10/1445 AH.
//

import Foundation
import Combine

final class MockArticleAPIServiceImp: ArticleAPIService {

    let articles: [ArticleModel]
    
    init(articles: [ArticleModel]?) {
        self.articles = articles ?? [DeveloperPreview.instance.article]
    }
    
    func fetchArticle() -> AnyPublisher<[ArticleModel],Error> {
        Just(articles)
            .tryMap ({ publishedArticle in
                guard !publishedArticle.isEmpty else {
                    throw NetworkingManager.NetworkingError.invalidData
                }
                return publishedArticle
            })
            .eraseToAnyPublisher()
    }
}
