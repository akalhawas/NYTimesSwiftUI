//
//  ArticleAPIService.swift
//  NYTimesSwiftUI
//
//  Created by ali alhawas on 14/10/1445 AH.
//

import Foundation
import Combine

protocol ArticleAPIService {
    func fetchArticle() -> AnyPublisher<ArticleResponse,Error>
}

class ArticleAPIServiceImp: ArticleAPIService {
    func fetchArticle() -> AnyPublisher<ArticleResponse,Error> {
        let urlString = "https://api.nytimes.com/svc/mostpopular/v2/emailed/1.json?api-key=n2G4UgyliHFmfxxENCyOst0RGDLOZFGN"
        let url = URL(string: urlString)!
        return NetworkingManager.download(url: url)
            .decode (type: ArticleResponse.self,decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

