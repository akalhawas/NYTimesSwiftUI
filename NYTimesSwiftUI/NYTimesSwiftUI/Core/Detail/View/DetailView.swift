//
//  DetailView.swift
//  NYTimesSwiftUI
//
//  Created by ali alhawas on 14/10/1445 AH
//

import SwiftUI

struct DetailView: View {
    @State var article: ArticleModel
    
    var body: some View {
        ZStack {
            VStack {
                headerImage
                content
            }
            .navigationTitle(article.section)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    return DetailView(article: DeveloperPreview.instance.article)
}

private extension DetailView {
    var headerImage: some View {
        VStack {
            if !article.imageUrl440.isEmpty {
                AsyncImage(url: URL(string: article.imageUrl440)) { image in
                    switch image {
                        case .empty:
                            Rectangle()
                                .fill(.ultraThinMaterial)
                                .overlay { ProgressView() }
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        case .failure( _):
                            Image("emptyState")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        @unknown default:
                            Image("emptyState")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                    }
                }
                .frame(maxHeight: 300)
            } else {
                Image("emptyState")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 300)
            }
 
        }
    }
    
    var content: some View {
        VStack(alignment: .leading) {
            
            VStack {
                HStack {
                    Text(article.publishedDate)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(article.source)
                        .foregroundStyle(.secondary)
                }
                Divider()
            }
            .padding([.leading, .trailing], 10)
            

            ScrollView {
                VStack(alignment: .leading,spacing: 10) {
                    Text(article.title)
                        .font(.title2).bold()
                    Text(article.abstract)
                }
                .padding([.leading, .trailing], 10)
            }
            
            HStack {
                Spacer()
                Text(article.byline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
            .padding([.leading, .trailing], 10)
        }
    }
}
