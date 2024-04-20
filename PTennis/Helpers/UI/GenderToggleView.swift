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
                        .foregroundColor(Color(toggleOn ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1028798084) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6039008336)))
                )
                .frame(width: 300, height: 50)

            ZStack{
                RoundedRectangle(cornerRadius: 10.0)
                    .stroke(.dark, lineWidth: 2)
                    .background(
                        RoundedRectangle(cornerRadius: 10.0)
                            .foregroundColor(.lightGreen)
                    )
                    .frame(width:150, height:40)

                Image(systemName: toggleOn ? "mustache" : "mouth")
                    .font(.system(size: 40))
            }
            .shadow(color: .black.opacity(0.14), radius: 4, x: 0, y: 2)
            .offset(x:toggleOn ? 70 : -70)
            .padding(24)
        }
        .padding(.horizontal, 20)
        .sensoryFeedback(.impact(flexibility: .soft, intensity: 0.5), trigger: toggleOn)
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
