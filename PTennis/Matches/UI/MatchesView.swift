//
//  MatchView.swift
//  PTennis
//
//  Created by Мирсаит Сабирзянов on 21.04.2024.
//

import SwiftUI

struct MatchesView: View {
    
    @StateObject private var dataManager = DataManager()
    @StateObject var viewModel = MatchesViewModel()
    let authUser = try? AuthManager.shared.getAuthUser()
    @State private var showAddSheet = false
    
    init() {
     UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
     UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
   }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.bcolor
                    .ignoresSafeArea()
                
                if viewModel.matches.isEmpty {
                    if viewModel.isLoading {
                        ProgressView()
                            .navigationTitle("Matches")
                            .task {
                                try? await viewModel.getAllMatches()
                            }
                    } else {
                        Text("There are no added matches yet")
                            .foregroundStyle(.white)
                            .font(.system(size: 42, design: .rounded))
                    }
                    Spacer()
                } else {
                    ScrollView {
                        LazyVStack {
                            ForEach(Array(viewModel.matches.enumerated()), id: \.element.id) { index, match in
                                MatchCardView(num: String(index + 1), match: match, player1: viewModel.getPlayer(by: match.player1), player2: viewModel.getPlayer(by: match.player2))
                            }
                        }
                        .navigationTitle("Matches")
                        .task {
                            try? await viewModel.getAllMatches()
                        }
                    }
                }
            }
        }

    }
}

#Preview {
    MatchesView()
}
