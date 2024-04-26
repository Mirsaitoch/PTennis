//
//  ContentView.swift
//  PTennis
//
//  Created by Мирсаит Сабирзянов on 05.04.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectedTab = "tennis.racket.circle"
    
    var body: some View {
        ZStack(){
            Color
                .paleGreen
                .ignoresSafeArea()
            VStack {
                switch selectedTab {
                case "tennis.racket.circle":
                    PlayersView()
                case "trophy":
                    MatchesView()
                case "person":
                    ProfileView()
                default:
                    MatchesView()
                }
                CustomTabBar(selectedTab: $selectedTab)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ContentView()
}
