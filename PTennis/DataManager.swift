//
//  DataManager.swift
//  PTennis
//
//  Created by Мирсаит Сабирзянов on 19.04.2024.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

class DataManager: ObservableObject {
    
    static let shared = DataManager()
    
    
    init() { }
    
    private let playersCollection = Firestore.firestore().collection("Players")
    
    private func playerDocument(playerId: String) -> DocumentReference {
        playersCollection.document(playerId)
    }
    
    
    func getAllPlayers() async throws  -> [Player] {
        
        let snapshot = try await playersCollection.getDocuments()
        var players : [Player] = []

        for document in snapshot.documents {
            
            let player = try document.data(as: Player.self)
            
            print(player)
            
            players.append(player)
        }
                
        return players
    }
    
    
    func addPlayer(player: Player) async throws {
        
        let userData : [String: Any] =
        ["id": player.id,
         "name": player.name,
         "surname": player.surname,
         "gender": player.gender,
         "rating": player.rating,
         "age": player.age,
         "phone": player.phone,
         "email": player.email]
        
        try await Firestore.firestore()
            .collection("Players")
            .document("\(player.id)")
            .setData(userData, merge: false)
        
    }
}
