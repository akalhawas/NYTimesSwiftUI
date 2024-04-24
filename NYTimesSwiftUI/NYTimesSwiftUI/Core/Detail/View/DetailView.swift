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
    
    var headerImage: some View {
        Section {
            if let media = article.media.first {
                if let image440 = media.mediaMetadata.first(where: {$0.format == "mediumThreeByTwo440"}) {
                    AsyncImage(url: URL(string: image440.url)){ image in
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
                } else {
                    Rectangle()
                        .frame(maxHeight: 293)
                }
            }
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
                VStack(spacing: 10) {
                    Text(article.title)
                        .font(.title2).bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
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
