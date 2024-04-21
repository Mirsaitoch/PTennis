//
//  ContentView.swift
//  PTennis
//
//  Created by Мирсаит Сабирзянов on 05.04.2024.
//

import SwiftUI

struct ContentView: View {

    @State private var selectedTab = "person"

    var body: some View {
        VStack(){
            
            Spacer()
            
            CustomTabBar(selectedTab: $selectedTab)
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ContentView()
}
