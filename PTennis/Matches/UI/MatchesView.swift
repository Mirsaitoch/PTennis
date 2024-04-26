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
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.paleGreen
                    .ignoresSafeArea()
                
                if viewModel.matches.isEmpty {
                    ProgressView()
                        .navigationTitle("Matches")
                        .task {
                            try? await viewModel.getAllMatches()
                        }
                } else {
                    ScrollView {
                        VStack {
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
