//
//  MatchTextFieldView.swift
//  PTennis
//
//  Created by Мирсаит Сабирзянов on 22.04.2024.
//

import SwiftUI

struct MatchTextFieldView: View {
    
    @Binding var score1: Int
    @Binding var score2: Int
    @State var round_number: Int

    var body: some View {
        
        RoundedRectangle(cornerRadius: 15)
            .fill(.lightGreen)
            .frame(width: 170, height: 120)
            .overlay {
                VStack(alignment: .leading) {
                    Text("Round \(round_number)")
                        .font(.system(size: 20, design: .rounded))
                        .foregroundStyle(.dark)
                        .padding([.top, .leading], 20)
                        
                    HStack(alignment: .center) {
                        Spacer()
                        Picker("RUN", selection: $score1)
                        {
                            ForEach((0...50), id: \.self)
                            {Text("\($0)")}
                        }
                        .frame(width: 60, height: 80).clipped()
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
                        .frame(width: 60, height: 80).clipped()
                        .pickerStyle(WheelPickerStyle())
                        
                        Spacer()
                    }
                    Spacer()
                }
            }
    }
}

#Preview {
    MatchTextFieldView(score1: .constant(0), score2: .constant(0), round_number: 1)
}
