//
//  Match.swift
//  PTennis
//
//  Created by Мирсаит Сабирзянов on 22.04.2024.
//

import Foundation
import SwiftUI

struct Match: Identifiable, Codable, Comparable {
    
    static func == (lhs: Match, rhs: Match) -> Bool {
        lhs.id == rhs.id
    }
    
    static func < (lhs: Match, rhs: Match) -> Bool {
        lhs.date < rhs.date
    }
    
    var id: String
    var date: Date
    var player1: String
    var player2: String
    var score1_1: Int
    var score1_2: Int
    var score2_1: Int
    var score2_2: Int
    var score3_1: Int
    var score3_2: Int
    var winner: Int

    
    static let example = Match(id: "qwertyuiop", date: Date.now, player1: "Player1", player2: "Player2", score1_1: 0, score1_2: 1, score2_1: 1, score2_2: 0, score3_1: 1, score3_2: 1, winner: 1)
}
