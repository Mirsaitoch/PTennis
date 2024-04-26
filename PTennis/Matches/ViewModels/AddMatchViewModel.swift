//
//  AddMatchViewModel.swift
//  PTennis
//
//  Created by Мирсаит Сабирзянов on 22.04.2024.
//

import Combine
import Foundation
import SwiftUI

@Observable
final class AddMatchViewModel {
    
    private(set) var players: [Player] = []
    private var dataManager = DataManager.shared
    private var cancellables: Set<AnyCancellable> = []
    
    
    init() {
        dataManager.$players
            .sink { [weak self] players in
                self?.players = players.sorted()
            }
            .store(in: &cancellables)
    }
    
    var date: Date = Date()
    var player1: Player? = nil
    var player2: Player? = nil
    var score1: (Int, Int) = (0, 0)
    var score2: (Int, Int) = (0, 0)
    var score3: (Int, Int) = (0, 0)
    
    var error_text = ""
    
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
        if player1Wins > player2Wins {
            return 1
        }
        else {
            return 2
        }
    }
    
    
    func getAllPlayers() async throws {
        self.players = try await DataManager().getAllPlayers()
    }
    
    func createNewMatch() async throws {
        
        let match = Match(id: generateUniqueUUID(), date: date, player1: player1?.id ?? "", player2: player2?.id ?? "", score1_1: score1.0, score1_2: score1.1, score2_1: score2.0, score2_2: score2.1, score3_1: score3.0, score3_2: score3.1, winner: matchResult)
        
        error_text = ""
        
        try await DataManager.shared.addMatch(match: match)
        
        if matchResult > 0 {
            try await DataManager().updatePlayerRating(player: player1 ?? Player.example, isWin: matchResult == 1)
            
            try await DataManager().updatePlayerRating(player: player2 ?? Player.example, isWin: matchResult == 2)
        }
        
        
        //подсчет рейтинга у игроков
        
    }
    
    func generateUniqueUUID() -> String {
        return "\(UUID())"
    }
}

