//
//  PlayersView.swift
//  PTennis
//
//  Created by Мирсаит Сабирзянов on 19.04.2024.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

@MainActor
final class PlayersViewModel: ObservableObject {
    
    @Published private(set) var players: [Player] = []
    
    func logOut() throws {
        try AuthManager.shared.signOut()
    }
    
    func getAllPlayers() async throws {
        self.players = try await DataManager().getAllPlayers()
    }
}

struct PlayersView: View {
    @StateObject private var dataManager = DataManager()
    @StateObject var viewModel = PlayersViewModel()
    @Binding var showSignInView: Bool
    let authUser = try? AuthManager.shared.getAuthUser()
    
    var body: some View {
        NavigationStack {
            if viewModel.players.isEmpty {
                ProgressView()
                    .navigationTitle("Top players")
                    .task {
                        try? await viewModel.getAllPlayers()
                    }
            } else{
                ScrollView {
                    VStack {
                        ForEach(Array(viewModel.players.enumerated()), id: \.element.id) { index, player in
                            PlayerCardView(num: String(index + 1), player: player)
                        }
                    }
                    .navigationTitle("Top players")
                    .task {
                        try? await viewModel.getAllPlayers()
                    }
                }
            }
            
        }
    }
}

func addPlayer() async throws {
    let player = Player(id: "\(Int.random(in: 0...1000000000))",
                        name: "Mirsaitik",
                        surname: "Sabirzyanov",
                        rating: 10,
                        gender: "Female",
                        age: 20,
                        phone: 89872891527,
                        email: "erimoerim@oeitng.t")
    
    try await DataManager.shared.addPlayer(player: player)
}


#Preview {
    PlayersView(showSignInView: .constant(false))
}
