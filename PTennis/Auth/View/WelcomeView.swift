//
//  WelcomeView.swift
//  PTennis
//
//  Created by Мирсаит Сабирзянов on 19.04.2024.
//

import SwiftUI

struct WelcomeView: View {
    @AppStorage("welcomeFirst") var isFirst = true
    
    var body: some View {
        Text("q")
//        NavigationStack{
//            VStack(){
//                Image("start_ball")
//                    .resizable()
//                    .frame(width: 250, height: 250)
//                    .padding(.top, 40)
//                Spacer()
//                Text("PTennis")
//                    .font(Font(CTFont(.label, size: 48)))
//                    .bold()
//                Spacer()
//                NavigationLink {
//                    LogInView()
//                } label: {
//                    GreyButtonView(text: "Log in as admin")
//                        .padding(.bottom, 50)
//                }
//                NavigationLink {
//                    ContentView()
//                } label: {
//                    GreyButtonView(text: "Continue as guest")
//                }
//                Spacer()
//            }
//        }
    }
}

#Preview {
    WelcomeView()
}
