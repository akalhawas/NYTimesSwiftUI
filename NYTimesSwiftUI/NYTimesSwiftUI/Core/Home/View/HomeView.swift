//
//  HomeView.swift
//  NYTimesSwiftUI
//
//  Created by ali alhawas on 14/10/1445 AH.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    @State private var hasAppeared = false
    
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                content
            }
            .navigationTitle("Articles".uppercased())
            .navigationBarItems(trailing: reloadIcon.opacity(vm.hasError ? 1 : 0))
        }
        .alert(isPresented: $showAlert, content: {
            return Alert(title: Text(alertTitle))
        })
        .task {
            if !hasAppeared {
                await vm.fetchArticles()
                errorCheck()
                hasAppeared = true
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel(articleAPIService: ArticleAPIServiceImp()))
}

// MARK: Views
private extension HomeView {
    var content: some View {
        Group {
            if vm.isLoading {
                LoadingView(title: "Downloading ...")
            } else {
                if vm.articles.isEmpty {
                    NYEmptyView()
                } else {
                    articleList
                }
            }
        }
    }
    
    var articleList: some View {
        List {
            ForEach(vm.articles, id: \.id) { article in
                NavigationLink(destination: DetailView(article: article)) {
                    ListRow(title: "\(article.title)", icon: "newspaper", hasImage: !article.imageUrl440.isEmpty)
                }
            }
        }
    }
    
    var reloadIcon: some View {
        Button(action: {
            Task {
                await vm.fetchArticles()
                errorCheck()
            }
        }, label: {
            Image(systemName: "arrow.clockwise")
        })
    }
}

// MARK: Functions
private extension HomeView {
    private func errorCheck(){
        if vm.hasError {
            if vm.isFinished {
                showAlert(title: "\(vm.error!.errorDescription!)! ")
            }
        }
    }
    
    private func showAlert(title: String){
        alertTitle = title
        showAlert.toggle()
    }
}
