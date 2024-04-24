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
                Spacer()
            }
            .navigationTitle(article.section)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    let article = DeveloperPreview.instance.article
    return DetailView(article: article)
}

private extension DetailView {
    
    var background: some View {
        Color.white.ignoresSafeArea()
    }
    
    var headerImage: some View {
        Section {
            AsyncImage(url: URL(string: article.imageUrl440)){ image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .frame(maxHeight: 293)
                    .overlay {
                        ProgressView()
                    }
            }
        }
    }
    
    var content: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(article.publishedDate)
                    .foregroundStyle(.secondary)
                Spacer()
                Text(article.source)
                    .foregroundStyle(.secondary)
            }
            .padding([.leading, .trailing], 10)
            Divider()

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
            }
            .padding([.leading, .trailing], 10)
        }
    }
}
