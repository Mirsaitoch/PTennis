//
//  WelcomeView.swift
//  PTennis
//
//  Created by Мирсаит Сабирзянов on 19.04.2024.
//

import SwiftUI

struct WelcomeView: View {
    @State private var isShown = false

    var body: some View {
        VStack {
            Button("Нажми меня") {
                withAnimation {
                    isShown.toggle()
                }
            }

            if isShown {
                Text("Привет, Мир!")
                    .transition(.asymmetric(insertion: .opacity, removal: .slide))
            }
        }
    }
}

#Preview {
    WelcomeView()
}
