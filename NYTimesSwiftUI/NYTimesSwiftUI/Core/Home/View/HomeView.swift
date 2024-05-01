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
    
    var body: some View {
        ZStack{
            VStack(spacing: 0){
//                ScrollView(showsIndicators: false) {
                    content
//                }
            }
            .navigationTitle("Articles".uppercased())
            .navigationBarItems(trailing: reloadIcon.opacity(vm.hasError ? 1 : 0))
        }
        .onChange(of: vm.hasError, perform: { value in
            errorCheck()
        })
        .alert(isPresented: $showAlert, content: {
            return Alert(title: Text(alertTitle))
        })
    }
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel(articleAPIService: ArticleAPIServiceImp()))
}

private extension HomeView {
    var content: some View {
        VStack {
            articlesRow
        }
    }
    
    var articlesRow: some View {
        VStack {
            if vm.isLoading {
                ProgressView()
            } else {
                if $vm.articles.isEmpty {
                    Text("No Values")
                        .frame(maxWidth: .infinity)
                } else {
                    List {
                        ForEach(vm.articles, id: \.id) { article in
                            NavigationLink(destination: DetailView(article: article)) {
                                ListRow(title: "\(article.title)", icon: "newspaper", hasImage: !article.imageUrl440.isEmpty)
                            }
                        }
                    }
                }
            }
        }
    }
    
    var reloadIcon: some View {
        Button(action: {
            vm.reloadData()
        }, label: {
            Image(systemName: "arrow.clockwise")
        })
    }
}

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
