//
//  NYEmptyView.swift
//  NYTimesSwiftUI
//
//  Created by ali alhawas on 27/10/1445 AH.
//

import SwiftUI

struct NYEmptyView: View {
    
    var title: String = ""
    
    var body: some View {
        VStack {
            Text(title)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .opacity(title.isEmpty ? 0 : 1)
            Image("no-search-results")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .padding(20)
    }
}

#Preview {
    NYEmptyView(title: "No Values ...")
}
