//
//  AddMatchViewModel.swift
//  PTennis
//
//  Created by Мирсаит Сабирзянов on 22.04.2024.
//


import Foundation
import SwiftUI

@Observable
final class AddMatchViewModel {
        
    var date: Date = Date()
    var player1: String = "generateUniqueUUID()"
    var player2: String = "generateUniqueUUID()"
    var score1: (Int?, Int?) = (0, 0)
    var score2: (Int?, Int?) = (0, 0)
    var score3: (Int?, Int?) = (0, 0)
    
    var error_text = ""
    
    

    func createNewMatch() async throws {
        
        let match = Match(id: generateUniqueUUID(), date: date, player1: player1, player2: player2, score1: "0 : 0", score2: "0 : 0", score3: "0 : 0")
        
        error_text = ""
        
        try await DataManager.shared.addMatch(match: match)
                
    }
    
    func generateUniqueUUID() -> String {
        return "\(UUID())"
    }
}

