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
        NavigationStack {
            ZStack {
                Color.bcolor.ignoresSafeArea()
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: "person.crop.circle.fill")
                            .foregroundStyle(.white)
                            .font(.system(size: 175))
                        Spacer()
                    }
                    .padding(.bottom, 70)
                    
                    Text("Email: \(authUser?.email == "" ? "You came in as a guest" : authUser?.email ?? "no email")")
                        .foregroundStyle(.white)
                        .font(.system(size: 30, design: .rounded))
                    
                    Text("ID: \(authUser?.uid ?? "no id")")
                        .foregroundStyle(.white)
                        .font(.system(size: 20, design: .rounded))
                    
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
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
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
                        Image(.exit)
                            .resizable()
                            .frame(width: 35, height: 35)
                    }
                }
            }
            .sheet(isPresented: $showAddPlayerSheet) {
                AddPlayerView()
            }
            .sheet(isPresented: $showAddMatchSheet) {
                AddMatchView()
            }
        }
    }
}

#Preview {
    ProfileView(selectedTab: .constant(""))
}
