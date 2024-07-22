//
//  Player.swift
//  PTennis
//
//  Created by Мирсаит Сабирзянов on 19.04.2024.
//

import Foundation
import SwiftUI

struct Player: Identifiable, Codable, Comparable, Hashable {
    static func < (lhs: Player, rhs: Player) -> Bool {
        if lhs.name != rhs.name {
            return lhs.name < rhs.name
        } else {
            return lhs.surname < rhs.surname
        }
    }
    
    static func ==(lhs: Player, rhs: Player) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: String
    var name: String
    var surname: String
    var rating: Int?
    var gender: String?
    var age: Int
    var phone: String?
    var email: String?
    
    static let example = Player(id: "qwertyu", name: "Test", surname: "Testovoy", age: 0)
}

