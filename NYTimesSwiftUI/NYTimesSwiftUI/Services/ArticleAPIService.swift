//
//  ArticleAPIService.swift
//  NYTimesSwiftUI
//
//  Created by ali alhawas on 14/10/1445 AH.
//

import Foundation
import Combine

protocol ArticleAPIService {
    func fetch<T: Codable>(type: T.Type) -> AnyPublisher<T,Error>
}

class ArticleAPIServiceImp: ArticleAPIService {
    func fetch<T: Codable>(type: T.Type) -> AnyPublisher<T,Error> {
        let urlString = "https://api.nytimes.com/svc/mostpopular/v2/emailed/1.json?api-key=n2G4UgyliHFmfxxENCyOst0RGDLOZFGN"
        let url = URL(string: urlString)!
        return NetworkingManager.download(url: url)
            .decode (type: type,decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

