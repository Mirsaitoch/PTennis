//
//  AddPlayerViewModel.swift
//  PTennis
//
//  Created by Мирсаит Сабирзянов on 20.04.2024.
//

import Foundation
import SwiftUI

final class AddPlayerViewModel: ObservableObject {
        
    @Published var name_surname: String = ""
    @Published var rating: String = ""
    @Published var age: String = ""
    @Published var gender: Bool = false
    @Published var phone: String = ""
    @Published var email: String = ""
    
    @Published var error_text = ""
    
    var name_surname_array: [String] {
        return name_surname.split(separator: " ").map(String.init)
    }

    var ageInt : Int {
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
        guard name_surname_array.count >= 2, name_surname_array[0].count >= 2, name_surname_array[0].count >= 2 else {
            print("error")
            DispatchQueue.main.async {
                self.error_text = "Enter the correct first and last name"
            }
            return
        }
        
        guard let age = Int(age) else {
            print("error")
            DispatchQueue.main.async {
                self.error_text = "Specify the age"
            }
            return
        }
        
        guard isValidEmail(email) else {
            print("error")
            DispatchQueue.main.async {
                self.error_text = "Enter the correct email address"
            }
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
        
        DispatchQueue.main.async {
            self.error_text = ""
        }
        

        try await DataManager.shared.addPlayer(player: player)
        
    }
    
    func generateUniqueUUID() -> String {
        return "\(UUID())"
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
