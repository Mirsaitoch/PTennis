//
//  RootView.swift
//  PTennis
//
//  Created by Мирсаит Сабирзянов on 20.04.2024.
//

import SwiftUI

struct RootView: View {
    
    @State private var showSignInView: Bool = false
    @State private var selectedTab: String = "tennis.racket.circle"

    var body: some View {
        ZStack(alignment: .bottom) {
                NavigationStack {
                    VStack {
                        ContentView(selectedTab: $selectedTab, showSignInView: $showSignInView)
                    }
                }
            
            CustomTabBar(selectedTab: $selectedTab)
        }
        .onAppear {
            let authUser = try? AuthManager.shared.getAuthUser()
            self.showSignInView = authUser == nil
        }
        .fullScreenCover(isPresented: $showSignInView) {
            NavigationStack {
                LogInView(showSignInView: $showSignInView)
            }
        }
    }
}

#Preview {
    RootView()
}
