//
//  MatchesViewModel.swift
//  PTennis
//
//  Created by Мирсаит Сабирзянов on 26.04.2024.
//

import Combine
import Foundation
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI


@MainActor
final class MatchesViewModel: ObservableObject {
    
    @Published private(set) var matches: [Match] = []
    private var dataManager = DataManager.shared
    private var cancellables: Set<AnyCancellable> = []
    @Published var sorted_in_reverse_order = false
    
    init() {
        dataManager.$matches
            .sink { [weak self] matches in
                self?.matches = matches.sorted()
            }
            .store(in: &cancellables)
    }
    
    func getPlayer(by id: String) -> Player {
        guard let index = dataManager.players.firstIndex(where: { $0.id == id }) else { return Player.example }
        return dataManager.players[index]
    }
    
    func getAllMatches() async throws {
        self.matches = try await DataManager().getAllMatches()
    }
    
}

