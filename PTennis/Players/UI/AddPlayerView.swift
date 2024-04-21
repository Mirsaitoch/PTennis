//
//  AddPlayerView.swift
//  PTennis
//
//  Created by Мирсаит Сабирзянов on 20.04.2024.
//

import SwiftUI
import CustomTextField

struct AddPlayerView: View {
    
    @State private var viewModel = AddPlayerViewModel()
    @Environment(\.dismiss) var dismiss
    
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
            VStack {
                ScrollView(showsIndicators: false) {
                    Image(.playerLogo)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 125, height: 125)
                        .padding(.bottom, 50)
                        .padding(.top, 30)
                    
                    Spacer()
                    
                    CustomTF(text: $viewModel.name_surname, placeholder: "Name Surname", ImageTF: Image(systemName: "person"), isPassword: false, StylesType: .Style2, KeyboardType: .default, color: nil)
                        .focused($focusedField, equals: .nameSurname)
                    
                    HStack {
                        Text(viewModel.error_text)
                            .foregroundColor(.red)
                            .font(.footnote)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    CustomTF(text: $viewModel.rating, placeholder: "Rating", ImageTF: Image(systemName: "star"), isPassword: false, StylesType: .Style2, KeyboardType: .numberPad, color: focusedField == .rating ? .lightGreen : nil)
                        .focused($focusedField, equals: .rating)
                    
                    CustomTF(text: $viewModel.age, placeholder: "Age", ImageTF: Image(systemName: "calendar"), isPassword: false, StylesType: .Style2, KeyboardType: .numberPad, color: focusedField == .age ? .green : nil)
                        .focused($focusedField, equals: .age)
                    
                    CustomTF(text: $viewModel.phone, placeholder: "Phone", ImageTF: Image(systemName: "teletype"), isPassword: false, StylesType: .Style2, KeyboardType: .phonePad, color: focusedField == .phone ? .green : nil)
                        .focused($focusedField, equals: .phone)
                    
                    CustomTF(text: $viewModel.email, placeholder: "Email", ImageTF: Image(systemName: "envelope"), isPassword: false, StylesType: .Style2, KeyboardType: .emailAddress, color: focusedField == .email ? .green : nil)
                        .focused($focusedField, equals: .email)
                    
                    GenderToggleView(toggleOn: viewModel.gender)
                    Button {
                        Task {
                            do {
                                try await viewModel.createNewPlayer()
                            }
                            catch {
                                print("error create user")
                            }
                            if viewModel.error_text == "" {
                                dismiss()
                            }
                        }
                    } label: {
                        GreenButtonView(text: "Add player")
                    }
                }
                .scrollClipDisabled()
                
                Spacer()
                
            }
            .padding()
            .navigationTitle("New player")
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
    AddPlayerView()
}
