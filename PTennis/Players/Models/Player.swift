//
//  Player.swift
//  PTennis
//
//  Created by Мирсаит Сабирзянов on 19.04.2024.
//

import Foundation
import SwiftUI

struct Player: Identifiable, Codable {
    let id: String
    var name: String
    var surname: String?
    var rating: Int?
    var gender: String?
    var age: Int?
    var phone: Int?
    var email: String?
}

