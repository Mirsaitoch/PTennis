//
//  BackButtonView.swift
//  PTennis
//
//  Created by Мирсаит Сабирзянов on 19.04.2024.
//

import SwiftUI

struct BackButtonView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Button {
            dismiss()
        } label: {
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .padding(1)
                .frame(width: 40, height: 40)
                .overlay {
                    Image(.back)
                        .resizable()
                        .frame(width: 32, height: 32)
                }
        }
    }
}

#Preview {
    BackButtonView()
}
