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
    @State var width: CGFloat
    @State var height: CGFloat

    var body: some View {
        
        RoundedRectangle(cornerRadius: 15)
            .fill(.primaryOne)
            .frame(width: width, height: height)
            .overlay {
                VStack(alignment: .leading) {
                    Text("Round \(round_number)")
                        .font(.system(size: 18, design: .rounded))
                        .foregroundStyle(.white)
                        .padding([.top, .leading], 20)
                        
                    HStack(alignment: .center) {
                        Picker("RUN", selection: $score1)
                        {
                            ForEach((0...50), id: \.self){
                                Text("\($0)")
                                    .foregroundStyle(.white)
                            }
                        }
                        .frame(width: width / 2.45, height: 2 * height / 3).clipped()
                        .pickerStyle(WheelPickerStyle())
                        
                        Text(":")
                            .foregroundStyle(.white)
                            .minimumScaleFactor(0.5)
                            .offset(y: -3)
                            .bold()
                        Picker("RUN", selection: $score2)
                        {
                            ForEach((0...50), id: \.self){
                                Text("\($0)")
                                    .foregroundStyle(.white)
                            }
                        }
                        .frame(width: width / 2.45, height: 2 * height / 3).clipped()
                        .pickerStyle(WheelPickerStyle())
                        
                    }
                    Spacer()
                }
            }
    }
}

#Preview {
    MatchTextFieldView(score1: .constant(0), score2: .constant(0), round_number: 1, width: 120, height: 120)
}
