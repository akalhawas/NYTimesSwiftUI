//
//  HomeViewModel.swift
//  NYTimesSwiftUI
//
//  Created by ali alhawas on 14/10/1445 AH.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
        
    @Published var articles: [ArticleModel] = []
    @Published private(set) var error: NetworkingManager.NetworkingError?
    
    @Published private(set) var hasError = false
    @Published private(set) var viewState: ViewState?
    @Published private(set) var imageUrl: String?
        
    var isLoading: Bool { viewState == .loading }
    
    private let articleAPIService: ArticleAPIService
    private var subscribers = Set<AnyCancellable>()
    
    init(articleAPIService: ArticleAPIService) {
        self.articleAPIService = articleAPIService
        addSubscribers()
    }
    
    func addSubscribers(){
        reset()
        viewState = .loading
        
        articleAPIService.fetchArticle()
            .sink { [weak self] completion in
                self?.handleCompletion(completion: completion)
            } receiveValue: { [weak self] (returnedArticles) in
                self?.viewState = .finished
                self?.articles = returnedArticles
            }.store(in: &subscribers)
    }
    
    func handleCompletion(completion: Subscribers.Completion<Error>){
        switch completion {
            case .finished: break
            case .failure(let error):
                self.hasError = true
                self.viewState = .finished
                if let networkingError = error as? NetworkingManager.NetworkingError {
                    self.error = networkingError
                } else {
                    self.error = .custom(error: error)
                }
        }
    }
    
    func reloadData(){
        addSubscribers()
    }
}

extension HomeViewModel {
    enum ViewState {
        case loading, finished
    }
}

private extension HomeViewModel {
    private func reset() {
        if viewState == .finished {
            articles.removeAll()
            viewState = nil
            error = nil
            hasError = false
        }
    }
}
