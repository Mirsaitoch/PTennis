//
//  ProfileView.swift
//  PTennis
//
//  Created by Мирсаит Сабирзянов on 21.04.2024.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @StateObject private var viewModel = ProfileViewModel()
    let authUser = try? AuthManager.shared.getAuthUser()
    @State private var showAddPlayerSheet = false
    @State private var showAddMatchSheet = false
    @AppStorage("isLoggedIn") var isLogin = false
    @Binding var selectedTab: String

    var body: some View {
        VStack {
            Spacer()
            Text(authUser?.uid ?? "no id")
            Text(authUser?.email ?? "no email")
            if authUser?.email != "" {
                Button {
                    showAddPlayerSheet.toggle()
                } label: {
                    GreenButtonView(text: " +  Add player")
                }
                Button {
                    showAddMatchSheet.toggle()
                } label: {
                    GreenButtonView(text: " +  Add match")
                }
            }
            Spacer()
            Button {
                Task {
                    do {
                        try viewModel.logOut()
                        appViewModel.isLogin = false
                        isLogin = false
                        selectedTab = "tennis.racket.circle"
                    }
                    catch {
                        print("error logOut")
                    }
                    
                }
            } label: {
                GreenButtonView(text: "Log out")
            }
            Spacer()

        }
        .sheet(isPresented: $showAddPlayerSheet) {
            AddPlayerView()
        }
        .sheet(isPresented: $showAddMatchSheet) {
            AddMatchView()
        }
    }
}

#Preview {
    ProfileView(selectedTab: .constant(""))
}
