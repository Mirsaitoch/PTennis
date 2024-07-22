//
//  AddMatchViewModel.swift
//  PTennis
//
//  Created by Мирсаит Сабирзянов on 22.04.2024.
//

import Combine
import Foundation
import SwiftUI

final class AddMatchViewModel: ObservableObject {
    
    private var dataManager = DataManager.shared
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var players: [Player] = []
    @Published var player1: Player? = nil
    @Published var player2: Player? = nil
    @Published var showAlert = false
    @Published var alertMessage: String = ""
    
    @Published var date: Date = Date()
    @Published var score1: (Int, Int) = (0, 0)
    @Published var score2: (Int, Int) = (0, 0)
    @Published var score3: (Int, Int) = (0, 0)
    
    init() {
        dataManager.$players
            .receive(on: DispatchQueue.main)
            .sink { [weak self] players in
                self?.players = players.sorted()
                self?.initializePlayers()
            }
            .store(in: &cancellables)
    }
    
    private func initializePlayers() {
        guard players.count >= 2 else { return }
        player1 = player1 ?? players[0]
        player2 = player2 ?? players[1]
    }
    
    var score1_str: String {
        "\(score1.0) : \(score1.1)"
    }
    
    var score2_str: String {
        "\(score2.0) : \(score2.1)"
    }
    
    var score3_str: String {
        "\(score3.0) : \(score3.1)"
    }
    
    var matchResult: Int {
        let player1Wins = [(score1.0 > score1.1), (score2.0 > score2.1), (score3.0 > score3.1)].filter { $0 }.count
        let player2Wins = [(score1.0 < score1.1), (score2.0 < score2.1), (score3.0 < score3.1)].filter { $0 }.count

        if player1Wins == player2Wins {
            return 0
        }
        return player1Wins > player2Wins ? 1 : 2
    }
    
    func getAllPlayers() async throws {
        let players = try await DataManager().getAllPlayers()
        DispatchQueue.main.async {
            self.players = players
            self.initializePlayers()
        }
    }
    
    func createNewMatch() async throws {
        guard let player1 = player1, let player2 = player2 else {
            showAlert(message: "You don't have enough players for the match")
            throw AddMatchError.notEnoughPlayers
        }
        
        guard validateScores() else {
            showAlert(message: "Scores cannot be (0, 0)")
            throw AddMatchError.invalidScores
        }
        
        let match = Match(
            id: generateUniqueUUID(),
            date: date,
            player1: player1.id,
            player2: player2.id,
            score1_1: score1.0,
            score1_2: score1.1,
            score2_1: score2.0,
            score2_2: score2.1,
            score3_1: score3.0,
            score3_2: score3.1,
            winner: matchResult
        )
        
        try await DataManager.shared.addMatch(match: match)
        
        if matchResult > 0 {
            try await DataManager().updatePlayerRating(player: player1, isWin: matchResult == 1)
            try await DataManager().updatePlayerRating(player: player2, isWin: matchResult == 2)
        }
    }
    
    private func validateScores() -> Bool {
        return !(score1 == (0, 0) || score2 == (0, 0) || score3 == (0, 0))
    }
    
    func generateUniqueUUID() -> String {
        return UUID().uuidString
    }
    
    private func showAlert(message: String) {
        DispatchQueue.main.async {
            self.showAlert = true
            self.alertMessage = message
        }
    }
}

enum AddMatchError: Error {
    case notEnoughPlayers
    case invalidScores
}
