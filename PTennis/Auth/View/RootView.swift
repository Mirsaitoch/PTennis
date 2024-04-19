//
//  RootView.swift
//  PTennis
//
//  Created by Мирсаит Сабирзянов on 20.04.2024.
//

import SwiftUI

struct RootView: View {
    
    @State private var showSignInView: Bool = false
    
    var body: some View {
        ZStack {
            NavigationStack {
                PlayersView(showSignInView: $showSignInView)
            }
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
