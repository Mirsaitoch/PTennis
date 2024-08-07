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
    @Published var matches: [Match] = []
    var isLoading = false

    init() {
        subscribeToPlayerUpdates()
    }
    
    deinit {
        listenerRegistrationPlayers?.remove()
        listenerRegistrationMatches?.remove()
    }
    
    private var listenerRegistrationPlayers: ListenerRegistration?
    private var listenerRegistrationMatches: ListenerRegistration?

    private let playersCollection = Firestore.firestore().collection("Players")
    private let matchesCollection = Firestore.firestore().collection("Matches")

    private func playerDocument(playerId: String) -> DocumentReference {
        playersCollection.document(playerId)
    }
    
    private func subscribeToPlayerUpdates() {
        listenerRegistrationPlayers = playersCollection.addSnapshotListener { [weak self] querySnapshot, error in
            guard let self = self else { return }
            if let error = error {
                print("Error getting player updates: \(error.localizedDescription)")
                return
            }
            
            guard let snapshot = querySnapshot else { return }
            
            snapshot.documentChanges.forEach { change in
                self.isLoading = true
                switch change.type {
                case .added:
                    if let player = try? change.document.data(as: Player.self) {
                        DispatchQueue.main.async {
                            self.players.append(player)
                            self.players.sort()
                            self.isLoading = false
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
        
        
        listenerRegistrationMatches = matchesCollection.addSnapshotListener { [weak self] querySnapshot, error in
            guard let self = self else { return }
            if let error = error {
                print("Error getting matches updates: \(error.localizedDescription)")
                return
            }
            
            guard let snapshot = querySnapshot else { return }
            
            snapshot.documentChanges.forEach { change in
                self.isLoading = true
                switch change.type {
                case .added:
                    if let match = try? change.document.data(as: Match.self) {
                        DispatchQueue.main.async {
                            self.matches.append(match)
                            self.matches.sort()
                            self.isLoading = false
                        }
                    }
                case .modified:
                    break
                case .removed:
                    break
                }
            }
        }

    }
    
    func getAllPlayers() async throws  -> [Player] {
        let snapshot = try await playersCollection.getDocuments()
        var players : [Player] = []
        self.isLoading = true
        for document in snapshot.documents {
            let player = try document.data(as: Player.self)
            players.append(player)
        }
        return players
    }
    
    func getAllMatches() async throws  -> [Match] {
        let snapshot = try await matchesCollection.getDocuments()
        var matches : [Match] = []
        self.isLoading = true
        for document in snapshot.documents {
            let match = try document.data(as: Match.self)
            matches.append(match)
        }
        return matches
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
        
        try await playersCollection
            .document("\(player.id)")
            .setData(userData, merge: false)
    }
    
    func addMatch(match: Match) async throws {
        
        let matchData : [String: Any] =
        ["id": match.id,
         "date": match.date,
         "player1": match.player1,
         "player2": match.player2,
         "score1_1": match.score1_1,
         "score1_2": match.score1_2,
         "score2_1": match.score2_1,
         "score2_2": match.score2_2,
         "score3_1": match.score3_1,
         "score3_2": match.score3_2,
         "winner": match.winner
        ]
        
        try await matchesCollection
            .document("\(match.id)")
            .setData(matchData, merge: false)
    }
    
    func updatePlayerRating(player: Player, isWin: Bool) async throws {
        //TODO: продумать что будет происходить при ничье 
        try await Firestore.firestore()
            .collection("Players")
            .document("\(player.id)")
            .updateData(["rating": player.rating! + (isWin ? 1 : -1)])
    }
}
