//
//  ContentView.swift
//  PTennis
//
//  Created by Мирсаит Сабирзянов on 05.04.2024.
//

import SwiftUI


struct ContentView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @State var selectedTab = "tennis.racket.circle"
    
    var body: some View {
            ZStack {
                Color.bcolor.ignoresSafeArea()
                VStack {
                    switch selectedTab {
                    case "tennis.racket.circle":
                        PlayersView()
                    case "trophy":
                        MatchesView()
                    case "person":
                        ProfileView(selectedTab: $selectedTab)
                    default:
                        MatchesView()
                    }
                    CustomTabBar(selectedTab: $selectedTab)
                }
            }
        }
}

#Preview {
    ContentView()
}
