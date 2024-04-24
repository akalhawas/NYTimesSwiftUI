//
//  ListRow.swift
//  NYTimesSwiftUI
//
//  Created by ali alhawas on 14/10/1445 AH.
//

import SwiftUI

struct ListRow: View {
    var title = "Article"
    var icon = "newspaper"
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .frame(width: 36, height: 36)
                .background(.ultraThinMaterial)
                .mask(Circle())
            Text(title)
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
            Spacer()
        }
        .foregroundColor(.primary)
    }
}

#Preview {
    ListRow()
}
