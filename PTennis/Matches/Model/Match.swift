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
    var score1: String
    var score2: String
    var score3: String
    
//    enum CodingKeys: String, CodingKey {
//        case id, date, player1, player2, score1, score2, score3
//    }
//    
//    // Custom method for Encodable conformance
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        
//        // Encode all properties
//        try container.encode(id, forKey: .id)
//        try container.encode(date, forKey: .date)
//        try container.encode(player1, forKey: .player1)
//        try container.encode(player2, forKey: .player2)
//        
//        // Encode score tuples as arrays
//        try container.encode([score1.0, score1.1], forKey: .score1)
//        try container.encode([score2.0, score2.1], forKey: .score2)
//        try container.encode([score3.0, score3.1], forKey: .score3)
//    }
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        
//        // Decode all properties
//        self.id = try container.decode(String.self, forKey: .id)
//        self.date = try container.decode(Date.self, forKey: .date)
//        self.player1 = try container.decode(String.self, forKey: .player1)
//        self.player2 = try container.decode(String.self, forKey: .player2)
//        
//        // Decode scores as arrays and then convert to tuples
//        let score1Array = try container.decode([Int].self, forKey: .score1)
//        let score2Array = try container.decode([Int].self, forKey: .score2)
//        let score3Array = try container.decode([Int].self, forKey: .score3)
//        
//        guard score1Array.count == 2 else {
//            throw DecodingError.dataCorruptedError(forKey: .score1,
//                                                   in: container,
//                                                   debugDescription: "Score tuple does not have exactly two elements")
//        }
//        
//        guard score2Array.count == 2 else {
//            throw DecodingError.dataCorruptedError(forKey: .score2,
//                                                   in: container,
//                                                   debugDescription: "Score tuple does not have exactly two elements")
//        }
//        
//        guard score3Array.count == 2 else {
//            throw DecodingError.dataCorruptedError(forKey: .score3,
//                                                   in: container,
//                                                   debugDescription: "Score tuple does not have exactly two elements")
//        }
//        
//        // Assign the decoded array elements to the respective tuple properties
//        self.score1 = (score1Array[0], score1Array[1])
//        self.score2 = (score2Array[0], score2Array[1])
//        self.score3 = (score3Array[0], score3Array[1])
//    }
}
