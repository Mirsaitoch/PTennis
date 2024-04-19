//
//  ContentView.swift
//  PTennis
//
//  Created by Мирсаит Сабирзянов on 05.04.2024.
//

import SwiftUI

struct ContentView: View {


    var body: some View {
        VStack(){
            GreyButtonView(text: "Main screen!")
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ContentView()
}
