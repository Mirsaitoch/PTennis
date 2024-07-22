//
//  PlayersViewModel.swift
//  PTennis
//
//  Created by Мирсаит Сабирзянов on 20.04.2024.
//
import Combine
import Foundation
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI


@MainActor
final class PlayersViewModel: ObservableObject {
    
    @Published private(set) var players: [Player] = []
    private var dataManager = DataManager.shared
    private var cancellables: Set<AnyCancellable> = []
    @Published var sorted_in_reverse_order = false
    @Published var isLoading = false

    
    init() {
        dataManager.$players
            .sink { [weak self] players in
                self?.players = players.sorted()
            }
            .store(in: &cancellables)
    }

    func getAllPlayers() async throws {
        self.players = try await DataManager().getAllPlayers()
        self.isLoading = dataManager.isLoading
    }
    
    func sortedInReverse() {
        self.players = players.sorted(by: >)
    }
    
    func sorted() {
        self.players = players.sorted(by: <)
    }
}
