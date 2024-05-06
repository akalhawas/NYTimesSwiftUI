//
//  LoadingView.swift
//  NYTimesSwiftUI
//
//  Created by ali alhawas on 27/10/1445 AH.
//

import SwiftUI

struct LoadingView: View {
    
    var title: String
    
    var body: some View {
        VStack(spacing: 10) {
            Text(title)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
            ProgressView()
        }
    }
}

#Preview {
    LoadingView(title: "Downloading ...")
}
