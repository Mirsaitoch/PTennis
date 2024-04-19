//
//  SignUpView.swift
//  PTennis
//
//  Created by Мирсаит Сабирзянов on 19.04.2024.
//

import SwiftUI
import Firebase
import FirebaseCore

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Email")
                    .font(.title2)
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

            }.padding(.horizontal, 40)
            
            VStack(alignment: .leading) {
                Text("Password")
                    .font(.title2)
                
                SecureField("Enter a password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }.padding(.horizontal, 40)
            
            Button {
                register()
            } label: {
                GreenButtonView(text: "Submit")
            }
        }
    }
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { res, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
}

#Preview {
    SignUpView()
}
