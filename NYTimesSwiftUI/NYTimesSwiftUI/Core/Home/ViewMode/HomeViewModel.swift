//
//  HomeViewModel.swift
//  NYTimesSwiftUI
//
//  Created by ali alhawas on 14/10/1445 AH.
//

import Foundation

final class HomeViewModel: ObservableObject {
        
    @Published var articles: [ArticleModel] = []
    
    @Published private(set) var error: NetworkingError?
    @Published private(set) var hasError = false
    @Published private(set) var viewState: ViewState?
    
    #if DEV
    private(set) var didReset = false
    #endif
    
    private let articleAPIService: ArticleAPIService
    
    var isLoading: Bool { viewState == .loading }
    var isFinished: Bool { viewState == .finished }
    
    enum ViewState {
        case loading, finished
    }
    
    init(articleAPIService: ArticleAPIService) {
        self.articleAPIService = articleAPIService
    }
}

// MARK: HomeViewModel
extension HomeViewModel {
    @MainActor
    func fetchArticles() async {
        reset()
        viewState = .loading

        defer { viewState = .finished }
        
        do {
            self.articles = try await articleAPIService.articles()
        } catch {
            self.hasError = true
            handleError(error: error)
        }
    }
}

// MARK: HomeViewModel Private Func
private extension HomeViewModel {
    private func handleError(error: Error){
        if let networkingError = error as? NetworkingError {
            self.error = networkingError
        } else {
            self.error = .custom(error: error)
        }
    }
    
    private func reset() {
        if viewState == .finished {
            articles.removeAll()
            viewState = nil
            error = nil
            hasError = false
        }
        
        #if DEV
        didReset = true
        #endif
    }
}

