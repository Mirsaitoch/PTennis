//
//  AddMatchView.swift
//  PTennis
//
//  Created by Мирсаит Сабирзянов on 22.04.2024.
//


import SwiftUI

struct AddMatchView: View {
    
    @StateObject var viewModel = AddMatchViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var date = Date()
    @FocusState private var focusedField: Field?
    @State var showAlert = false
    
    enum Field: Hashable {
        case nameSurname
        case rating
        case age
        case phone
        case email
    }
    
    init() {
     UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
     UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
   }
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(showsIndicators: false) {
                    Image(.matchLogo)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 125, height: 125)
                        .padding(.bottom, 50)
                        .padding(.top, 30)
                    
                    Spacer()
                    
                    DatePicker("Select a Date", selection: $date, displayedComponents: [.date, .hourAndMinute])
                        .datePickerStyle(.compact)
                        .padding(.bottom, 30)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.primaryOne)
                        .frame(width: 320, height: 50)
                        .overlay {
                            VStack(alignment: .leading) {
                                Spacer()
                                HStack {
                                    Text("Player 1: ")
                                        .padding(.leading, 10)
                                        .font(.system(size: 20, design: .rounded))
                                    Picker("Player 1", selection: $viewModel.player1) {
                                        ForEach(viewModel.players) { player in
                                            Text(player.name).tag(player as Player?)
                                        }
                                    }
                                    .accentColor(.white)
                                    Spacer()
                                }
                                Spacer()
                            }
                        }
                    
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.primaryOne)
                        .frame(width: 320, height: 50)
                        .overlay {
                            VStack(alignment: .leading) {
                                Spacer()
                                HStack {
                                    Text("Player 2: ")
                                        .padding(.leading, 10)
                                        .font(.system(size: 20, design: .rounded))
                                    Picker("Player 2", selection: $viewModel.player2) {
                                        ForEach(viewModel.players) { player in
                                            Text(player.name).tag(player as Player?)
                                        }
                                    }
                                    .accentColor(.white)
                                    Spacer()
                                }
                                Spacer()
                            }
                        }
                        .padding()
                    
                    GeometryReader { proxy in
                            HStack {
                                MatchTextFieldView(score1: $viewModel.score1.0, score2: $viewModel.score1.1, round_number: 1, width: proxy.size.width * 0.33, height: proxy.size.height)
                                
                                MatchTextFieldView(score1: $viewModel.score2.0, score2: $viewModel.score2.1, round_number: 2, width: proxy.size.width * 0.33, height: proxy.size.height)
                                
                                MatchTextFieldView(score1: $viewModel.score3.0, score2: $viewModel.score3.1, round_number: 3, width: proxy.size.width * 0.33, height: proxy.size.height)
                                Spacer()

                            }
                    }
                    .frame(height: 100)
                    
                    
                    Button {
                        Task {
                            do {
                                try await viewModel.createNewMatch()
                            }
                            catch {
                                print("Error create match")
                            }
                            if viewModel.alertMessage == "" {
                                dismiss()
                            } else {
                                print(viewModel.showAlert)
                            }
                        }
                    } label: {
                        GreenButtonView(text: "Add match")
                    }
                    
                }
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(title: Text("Error"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("ok!")))
                }
            }
            .foregroundStyle(.white)
            .padding()
            .background(.bcolor)
            .navigationTitle("New match")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                Task {
                    do {
                        try await viewModel.getAllPlayers()
                    } catch {
                        print("error: get players")
                    }
                }
            }
        }
    }
}

#Preview {
    AddMatchView()
}

