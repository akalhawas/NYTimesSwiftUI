//
//  ArticleAPIServiceImp.swift
//  NYTimesSwiftUI
//
//  Created by ali alhawas on 15/10/1445 AH.
//

import Foundation
import Combine

protocol ArticleAPIService {
    func fetchArticle() -> AnyPublisher<[ArticleModel],Error>
}

final class ArticleAPIServiceImp: ArticleAPIService {
    
    func fetchArticle() -> AnyPublisher<[ArticleModel],Error> {
        let urlString = "https://\(API.baseURL)/svc/mostpopular/v2/emailed/1.json?api-key=n2G4UgyliHFmfxxENCyOst0RGDLOZFGN"
        let url = URL(string: urlString)!
        return NetworkingManager.download(url: url)
            .decode (type: ArticleResponse.self,decoder: JSONDecoder())
            .compactMap{$0.results}
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
