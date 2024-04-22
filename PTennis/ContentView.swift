//
//  ContentView.swift
//  PTennis
//
//  Created by Мирсаит Сабирзянов on 05.04.2024.
//

import SwiftUI

struct ContentView: View {

    @Binding var selectedTab: String
    @Binding var showSignInView: Bool

    var body: some View {
        ZStack(){
            Color
                .paleGreen
                .ignoresSafeArea()
            VStack {
                switch selectedTab {
                case "tennis.racket.circle":
                    PlayersView(showSignInView: $showSignInView)
                case "trophy":
                    MatchesView()
                case "person":
                    ProfileView(showSignInView: $showSignInView)
                default:
                    MatchesView()
                }
//                CustomTabBar(selectedTab: $selectedTab)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ContentView(selectedTab: .constant(""), showSignInView: .constant(false))
}
