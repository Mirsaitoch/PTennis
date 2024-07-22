//
//  GreenButtonView.swift
//  PTennis
//
//  Created by Мирсаит Сабирзянов on 19.04.2024.
//

import SwiftUI

struct GreenButtonView: View {
    
    var text: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10.0)
            .foregroundStyle(.primaryOne)
            .frame(width: 250, height: 70)
            .overlay {
                Text(text)
                    .font(.system(size: 30, design: .rounded))
                    .foregroundStyle(.white)
                    .bold()
            }
            .padding(.vertical, 20)
    }
}

#Preview {
    GreenButtonView(text: "Submit")
}
