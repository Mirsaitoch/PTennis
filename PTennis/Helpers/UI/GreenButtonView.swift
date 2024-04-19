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
        RoundedRectangle(cornerRadius: 5.0)
            .stroke(.dark, lineWidth: 3)
            .fill(.lightGreen)
            .containerRelativeFrame(.horizontal){ width, axis in
                width * 0.5
            }
            .containerRelativeFrame(.vertical){ height, axis in
                height * 0.08
            }
            .overlay {
                Text(text)
                    .font(.title)
                    .foregroundStyle(.dark)
            }
    }
}

#Preview {
    GreenButtonView(text: "Submit")
}
