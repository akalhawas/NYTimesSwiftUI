//
//  ContentView.swift
//  NYTimesSwiftUI
//
//  Created by ali alhawas on 14/10/1445 AH.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
        
    @Published var articles: [ArticleModel] = []
    
    private let articleAPIService: ArticleAPIService
    private var subscribers = Set<AnyCancellable>()
    
    
    init(articleAPIService: ArticleAPIService) {
        self.articleAPIService = articleAPIService
        addSubscribers()
    }
    
    func addSubscribers(){
        articleAPIService.fetch(type: ArticleResponse.self)
            .sink { _ in
            } receiveValue: { [weak self] (returnedArticles) in
                self?.articles = returnedArticles.results
            }.store(in: &subscribers)
    }
}

struct ContentView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    
    var body: some View {
        ZStack{
            background
            VStack(spacing: 0){
                ScrollView(showsIndicators: false) {
                    content
                }
            }
            .navigationTitle("Articles".uppercased())
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(HomeViewModel(articleAPIService: ArticleAPIServiceImp()))
}

private extension ContentView {
    
    var background: some View {
        Color.white.ignoresSafeArea()
    }
    
    var content: some View {
        VStack {
            articlesRow
        }
    }
    
    var articlesRow: some View {
        VStack {
            if $vm.articles.isEmpty {
                HStack {
                    Text("No Values")
                        .frame(maxWidth: .infinity)
                }
            } else {
                ForEach(vm.articles, id: \.id) { article in
                    Text(article.title)
                }
            }
        }
        .padding(20)
        .padding(.horizontal, 10)
    }
}
