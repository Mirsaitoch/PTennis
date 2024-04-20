//
//  AddPlayerViewModel.swift
//  PTennis
//
//  Created by Мирсаит Сабирзянов on 20.04.2024.
//

import Foundation
import SwiftUI

@Observable
final class AddPlayerViewModel {
    
    var name_surname: String = ""
    var rating: String = ""
    var age: String = ""
    var gender: Bool = false
    var phone: String = ""
    var email: String = ""
    
    var name_surname_array: [String] {
        return name_surname.split(separator: " ").map(String.init)
    }

    var ageInt : Int? {
        Int(age) ?? 0
    }
    
    var ratingInt : Int? {
        Int(rating) ?? 0
    }
    
    var genderString : String? {
        if gender {
            return "Male"
        } else {
            return "Female"
        }
    }
    
    func createNewPlayer() async throws {
        guard name_surname_array.count >= 2 else {
            print("error")
            return
        }
        
        let player = Player(id: generateUniqueUUID(),
                            name: name_surname_array[0],
                            surname: name_surname_array[1],
                            rating: ratingInt,
                            gender: genderString,
                            age: ageInt,
                            phone: phone,
                            email: email)
        
        try await DataManager.shared.addPlayer(player: player)
    }
    
    func generateUniqueUUID() -> String {
        return "\(UUID())"
    }
}
