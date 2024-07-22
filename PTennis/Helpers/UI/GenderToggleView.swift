//
//  GenderToggleView.swift
//  PTennis
//
//  Created by Мирсаит Сабирзянов on 20.04.2024.
//

import SwiftUI

struct GenderToggleView: View {
    
    @State var toggleOn: Bool
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12.0)
                .stroke(.dark, lineWidth: 2)
                .background(
                    RoundedRectangle(cornerRadius: 12.0)
                        .foregroundColor(.white)
                )
                .frame(width: 300, height: 50)

            ZStack {
                RoundedRectangle(cornerRadius: 10.0)
                    .stroke(.dark, lineWidth: 2)
                    .background(
                        RoundedRectangle(cornerRadius: 10.0)
                            .foregroundColor(.primaryOne)
                    )
                    .frame(width:150, height:40)
                    .offset(x: toggleOn ? 70 : -70)

                Image(systemName: "mouth")
                    .font(.system(size: 40))
                    .offset(x: 70)

                Image(systemName: "mustache")
                    .font(.system(size: 40))
                    .offset(x: -70)

            }
            .shadow(color: .black.opacity(0.14), radius: 4, x: 0, y: 2)
            .padding(24)
        }
        .padding(.horizontal, 20)
        .onTapGesture {
            withAnimation(.spring()) {
                self.toggleOn.toggle()
            }
        }
    }
}

#Preview {
    GenderToggleView(toggleOn: false)
}
