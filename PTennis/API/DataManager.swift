//
//  DataManager.swift
//  PTennis
//
//  Created by Мирсаит Сабирзянов on 19.04.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class DataManager: ObservableObject {
    
    static let shared = DataManager()
    
    @Published var players: [Player] = []
    
    init() {
        subscribeToPlayerUpdates()
    }
    
    deinit {
        listenerRegistration?.remove()
    }
    
    private var listenerRegistration: ListenerRegistration?
    
    private let playersCollection = Firestore.firestore().collection("Players")
    
    private func playerDocument(playerId: String) -> DocumentReference {
        playersCollection.document(playerId)
    }
    
    private func subscribeToPlayerUpdates() {
        listenerRegistration = playersCollection.addSnapshotListener { [weak self] querySnapshot, error in
            guard let self = self else { return }
            if let error = error {
                print("Error getting player updates: \(error.localizedDescription)")
                return
            }
            
            guard let snapshot = querySnapshot else { return }
            
            snapshot.documentChanges.forEach { change in
                switch change.type {
                case .added:
                    if let player = try? change.document.data(as: Player.self) {
                        DispatchQueue.main.async {
                            self.players.append(player)
                            self.players.sort()
                        }
                    }
                case .modified:
                    if let player = try? change.document.data(as: Player.self) {
                        if let index = self.players.firstIndex(where: { $0.id == player.id }) {
                            DispatchQueue.main.async {
                                self.players[index] = player
                                self.players.sort()
                            }
                        }
                    }
                case .removed:
                    // Здесь можно удалить игрока из списка
                    break
                }
            }
        }
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
         "gender": player.gender ?? "Male",
         "rating": player.rating ?? 10,
         "age": player.age,
         "phone": player.phone ?? "89999999999",
         "email": player.email ?? "test@mail.ru"]
        
        try await Firestore.firestore()
            .collection("Players")
            .document("\(player.id)")
            .setData(userData, merge: false)
    }
    
    func addMatch(match: Match) async throws {
        
        let matchData : [String: Any] =
        ["id": match.id,
         "date": match.date,
         "player1": match.player1,
         "player2": match.player2,
         "score1": match.score1,
         "score2": match.score2,
         "score3": match.score3
        ]
        
        try await Firestore.firestore()
            .collection("Matches")
            .document("\(match.id)")
            .setData(matchData, merge: false)
    }
    
    func updatePlayerRating(player: Player, isWin: Bool) async throws {
        
        try await Firestore.firestore()
            .collection("Players")
            .document("\(player.id)")
            .updateData(["rating": player.rating! + (isWin ? 1 : -1)])
        
    }
    
//    func deletePlayer(at indexSet: IndexSet) {
//            let db = Firestore.firestore()
//            indexSet.forEach { index in
//                Firestore.firestore()
//                    .collection("Players")
//                    .document(playerID)
//                    .delete { error in
//                    if let error = error {
//                        print("Ошибка удаления документа: \(error)")
//                        return
//                    }
//                }
//            }
//        }
}
