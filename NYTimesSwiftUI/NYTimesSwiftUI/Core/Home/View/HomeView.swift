//
//  HomeView.swift
//  NYTimesSwiftUI
//
//  Created by ali alhawas on 14/10/1445 AH.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var vm: HomeViewModel
    
    @State var alertTitle: String = "false"
    @State var showAlert: Bool = false

    @State private var selectedAtricle: ArticleModel? = nil
    @State private var showDetailView: Bool = false
    
    var body: some View {
        ZStack{
            background
            
            VStack(spacing: 0){
                ScrollView(showsIndicators: false) {
                    content
                }
            }
        }
        .navigationTitle("Articles".uppercased())
        .navigationBarItems(trailing: reloadIcon.opacity(vm.hasError ? 1 : 0))
        .onAppear {
            errorCheck()
        }
        .alert(isPresented: $showAlert, content: {
            return Alert(title: Text(alertTitle))
        })
    }
    
    func errorCheck(){
        if vm.hasError {
            if vm.viewState == .finished {
                showAlert(title: "\(vm.error!.errorDescription!)! 😩")
            }
        }
    }
    
    func showAlert(title: String){
        alertTitle = title
        showAlert.toggle()
    }
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel(articleAPIService: ArticleAPIServiceImp()))
}

private extension HomeView {
    
    var background: some View {
        Color.white.ignoresSafeArea()
    }
    
    var content: some View {
        VStack {
            articlesSection
        }
    }
    
    var articlesSection: some View {
        VStack {
            if vm.viewState == .finished {
                if $vm.articles.isEmpty {
                    HStack {
                        Text("No Values")
                            .frame(maxWidth: .infinity)
                    }
                } else {
                    ForEach(vm.articles, id: \.id) { article in
                        NavigationLink(destination: EmptyView()) {
                            ListRow(title: "\(article.title)", icon: "newspaper")
                        }
                    }
                }
            } else {
                ProgressView() // while downloading
            }
        }
        .padding(20)
        .padding(.horizontal, 10)
    }
    
    var reloadIcon: some View {
        Button(action: {
            vm.reloadData()
            errorCheck()
        }, label: {
            Image(systemName: "arrow.clockwise")
        })
    }
    
    private func segue(article: ArticleModel) {
        selectedAtricle = article
        showDetailView.toggle()
    }
}

