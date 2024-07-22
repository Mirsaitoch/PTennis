//
//  GreyButtonView.swift
//  PTennis
//
//  Created by Мирсаит Сабирзянов on 19.04.2024.
//

import SwiftUI

struct GreyButtonView: View {
    
    var text: String
    @AppStorage("welcomeFirst") var isFirst = true

    var body: some View {
        RoundedRectangle(cornerRadius: 5.0)
            .foregroundStyle(.dark)
            .padding(.horizontal, 20)
            .overlay {
                Text(text)
                    .font(.title)
                    .foregroundStyle(.light)
            }
    }
}

#Preview {
    GreyButtonView(text: "Log in as admin")
}
