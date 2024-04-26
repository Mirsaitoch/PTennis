//
//  MatchCardView.swift
//  PTennis
//
//  Created by Мирсаит Сабирзянов on 26.04.2024.
//

import SwiftUI

struct MatchCardView: View {
    
    var num: String
    var match: Match
    var player1: Player
    var player2: Player
    var body: some View {
        
        RoundedRectangle(cornerRadius: 10)
            .fill(.lightGreen)
            .overlay {
                VStack() {
                    HStack {
                        Spacer()
                        Text("\(match.date.formatted(.dateTime))")
                            .italic()
                    }
                    .padding()
                    VStack{
                        HStack {
                            Image(.playerLogo)
                                .resizable()
                                .frame(width: 50, height: 50)
                            BigRect(name: "\(player1.name) \(player1.surname)")
                            
                            Spacer()
                            HStack{
                                SmallRect(num: match.score1_1, isBiggest: match.score1_1 > match.score1_2)
                                SmallRect(num: match.score2_1, isBiggest: match.score2_1 > match.score2_2)
                                SmallRect(num: match.score3_1, isBiggest: match.score3_1 > match.score3_2)
                            }
                        }
                        HStack {
                            Image(.playerLogo)
                                .resizable()
                                .frame(width: 50, height: 50)
                            
                            BigRect(name: "\(player2.name) \(player2.surname)")
                            
                            Spacer()
                            HStack {
                                SmallRect(num: match.score1_2, isBiggest: match.score1_1 < match.score1_2)
                                SmallRect(num: match.score2_2, isBiggest: match.score2_1 < match.score2_2)
                                SmallRect(num: match.score3_2, isBiggest: match.score3_1 < match.score3_2)
                            }
                        }
                    }
                    .padding()
                }
            }
            .frame(height: 200)
            .padding()
            .shadow(radius: 10)
    }
}

struct SmallRect: View {
    var num: Int
    var isBiggest: Bool
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .rotation(.degrees(8))
            .fill(.paleGreen)
            .opacity(isBiggest ? 1 : 0.7)
            .overlay {
                Text("\(num)")
                    .bold(isBiggest)
                    .opacity(isBiggest ? 1 : 0.4)
            }
            .frame(width: 30, height: 50)
    }
}

struct BigRect: View {
    var name: String
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(.paleGreen)
            .overlay {
                HStack {
                    Text(name)
                        .minimumScaleFactor(0.5)
                        .bold()
                    Spacer()
                }
                .padding(.leading, 8)
            }
            .frame(height: 50)
    }
}

#Preview {
    MatchCardView(num: "1", match: Match.example, player1: Player.example, player2: Player.example)
}
