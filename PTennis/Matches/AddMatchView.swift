//
//  AddMatchView.swift
//  PTennis
//
//  Created by Мирсаит Сабирзянов on 22.04.2024.
//


import SwiftUI
import CustomTextField

struct AddMatchView: View {
    
    @State private var viewModel = AddMatchViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var date = Date()
    
    enum Field: Hashable {
        case nameSurname
        case rating
        case age
        case phone
        case email
    }
    
    
    
    @FocusState private var focusedField: Field?
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .trailing) {
                ScrollView(showsIndicators: false) {
                    Image(.matchLogo)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 125, height: 125)
                        .padding(.bottom, 50)
                        .padding(.top, 30)
                    
                    Spacer()
                    
                    DatePicker("date", selection: $date)
                        .padding(.bottom, 30)
                        .frame(width: 200, height: 70)
                    VStack{
                        HStack {
                            MatchTextFieldView(score1: $viewModel.score1.0, score2: $viewModel.score1.1, round_number: 1)
                            
                            MatchTextFieldView(score1: $viewModel.score2.0, score2: $viewModel.score2.1, round_number: 2)
                        }
                        MatchTextFieldView(score1: $viewModel.score3.0, score2: $viewModel.score3.1, round_number: 3)
                        
                    }
                    
                    
                    
                    
                    //                    Button {
                    //                        Task {
                    //                            do {
                    //                                try await viewModel.createNewMatch()
                    //                            }
                    //                            catch {
                    //                                print("error create user")
                    //                            }
                    //                            if viewModel.error_text == "" {
                    //                                dismiss()
                    //                            }
                    //                        }
                    //                    } label: {
                    //                        GreenButtonView(text: "Add match")
                    //                    }
                    
                }
                .scrollClipDisabled()
                
                Spacer()
            }
            .padding()
            .navigationTitle("New match")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    BackButtonView()
                }
            }
        }
        .environment(\.colorScheme, .light)
    }
    
}

#Preview {
    AddMatchView()
}

