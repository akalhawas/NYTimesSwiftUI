//
//  NYTimesSwiftUIApp.swift
//  NYTimesSwiftUI
//
//  Created by ali alhawas on 14/10/1445 AH.
//

import SwiftUI

@main
struct NYTimesSwiftUIApp: App {
    @StateObject private var vm = HomeViewModelImp(articleAPIService: ArticleAPIServiceImp())
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .environmentObject(vm)
            }
            .onAppear{
                Log.environment()
            }
        }
    }
}
