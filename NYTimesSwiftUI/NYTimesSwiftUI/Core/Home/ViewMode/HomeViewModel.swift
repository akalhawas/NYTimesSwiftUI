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
    
    private let articleAPIService: ArticleAPIService
    private var subscribers = Set<AnyCancellable>()
    
    @Published private(set) var error: NetworkingManager.NetworkingError?
    @Published var hasError = false
    
    @Published private(set) var viewState: ViewState?
        
    var isLoading: Bool { viewState == .loading }
    var isFetching: Bool { viewState == .fetching }
    
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
                self?.articles = returnedArticles.results
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
        case fetching, loading, finished
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
