//
//  MatchTextFieldView.swift
//  PTennis
//
//  Created by Мирсаит Сабирзянов on 22.04.2024.
//

import SwiftUI

struct MatchTextFieldView: View {
    
    @Binding var score1: Int?
    @Binding var score2: Int?
    @State var round_number: Int
    
    let size = [0, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 22, 24, 26, 28, 30, 32]
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 15)
            .fill(.lightGreen)
            .frame(width: 180, height: 150)
            .overlay {
                VStack(alignment: .leading) {
                    Text("Round \(round_number)")
                        .font(.system(size: 20, design: .rounded))
                        .foregroundStyle(.dark)
                        .padding([.top, .leading])
                        
                    HStack(alignment: .center) {
                        Spacer()
                        Picker("RUN", selection: $score1)
                        {
                            ForEach((0...50), id: \.self)
                            {Text("\($0)")}
                        }
                        .frame(width: 60, height: 90).clipped()
                        .pickerStyle(WheelPickerStyle())
                        
                        Text(" : ")
                            .font(.system(size: 40))
                            .bold()
                            .offset(y: -3)
                        Picker("RUN", selection: $score2)
                        {
                            ForEach((0...50), id: \.self)
                            {Text("\($0)")}
                        }
                        .frame(width: 60, height: 90).clipped()
                        .pickerStyle(WheelPickerStyle())
                        
                        Spacer()
                    }
                    Spacer()
                }
            }
    }
}

#Preview {
    MatchTextFieldView(score1: .constant(nil), score2: .constant(nil), round_number: 1)
}
