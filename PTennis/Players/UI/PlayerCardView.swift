//
//  PlayerCardView.swift
//  PTennis
//
//  Created by Мирсаит Сабирзянов on 19.04.2024.
//

import SwiftUI

struct PlayerCardView: View {
    var num: String
    var player: Player
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(.primaryOne)
            .frame(minWidth: 100, maxWidth: .infinity, minHeight: 70)
            .overlay {
                HStack {
                    Text(num)
                        .padding(.leading, 10)
                    Image(.playerLogo)
                        .resizable()
                        .frame(width: 50, height: 50)
                    VStack(alignment: .leading) {
                        Text("\(player.name) \(player.surname)")
                            .font(.system(size: 25))
                            .bold()
                        Text("age: \(player.age)")
                            .font(.footnote)
                    }
                    Spacer()
                    Text("\(player.rating ?? 10, format: .number)")
                        .font(.system(size: 25))
                        .padding(.trailing, 10)
                }
            }
            .padding([.horizontal, .bottom], 10)
    }
}

#Preview {
    PlayerCardView(num: "1", player: Player.example)
}
