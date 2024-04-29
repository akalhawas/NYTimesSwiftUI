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
            
    private let articleAPIService: ArticleAPIService
    private var subscribers = Set<AnyCancellable>()

    var isLoading: Bool { viewState == .loading }
    
    init(articleAPIService: ArticleAPIService) {
        self.articleAPIService = articleAPIService
        addSubscribers()
    }
}

// MARK: HomeViewModel
extension HomeViewModel {
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
    
    enum ViewState {
        case loading, finished
    }
    
    func reloadData(){
        addSubscribers()
    }
}

// MARK: HomeViewModel Private Func
private extension HomeViewModel {
    private func handleCompletion(completion: Subscribers.Completion<Error>){
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
    
    private func reset() {
        if viewState == .finished {
            articles.removeAll()
            viewState = nil
            error = nil
            hasError = false
        }
    }
}
