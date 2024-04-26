//
//  LogInView.swift
//  PTennis
//
//  Created by Мирсаит Сабирзянов on 19.04.2024.
//

import SwiftUI
import Firebase
import Combine

//struct AdaptsToKeyboard: ViewModifier {
//    @State var currentHeight: CGFloat = 0
//    
//    func body(content: Content) -> some View {
//        GeometryReader { geometry in
//            content
//                .padding(.bottom, self.currentHeight)
//                .onAppear(perform: {
//                    NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillShowNotification)
//                        .merge(with: NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillChangeFrameNotification))
//                        .compactMap { notification in
//                            withAnimation(.easeOut(duration: 0.16)) {
//                                notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
//                            }
//                        }
//                        .map { rect in
//                            rect.height - geometry.safeAreaInsets.bottom
//                        }
//                        .subscribe(Subscribers.Assign(object: self, keyPath: \.currentHeight))
//                    
//                    NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillHideNotification)
//                        .compactMap { notification in
//                            CGFloat.zero
//                        }
//                        .subscribe(Subscribers.Assign(object: self, keyPath: \.currentHeight))
//                })
//        }
//    }
//}
//
//extension View {
//    func adaptsToKeyboard() -> some View {
//        return modifier(AdaptsToKeyboard())
//    }
//}

final class LogInModel: ObservableObject {
    @Published var email: String = ""
    @Published var password = ""
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("no email or pass")
            return
        }
        
        try await AuthManager.shared.signInUser(email: email, password: password)
    }
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("no email or password")
            return
        }
        try await AuthManager.shared.createUser(email: email, password: password)
    }
    
    func signInAnonymously() async throws {
        
        try await AuthManager.shared.signInAnonymously()
    }
}

struct LogInView: View {
    
    @State private var error_text = ""
    @Binding var showSignInView: Bool
    
    enum FocusedField {
        case username, password
    }
    
    @StateObject private var viewModel = LogInModel()
    @FocusState private var focusedField: FocusedField?
    @State private var isLoggedIn = false
    
    
    var body: some View {
        content
    }
    
    var content: some View {
        VStack(){
            Image("log_in_ball")
                .resizable()
                .frame(width: 170, height: 170)
                .padding(.top, 20)
            
            Spacer()
            
            Text("Log in")
                .font(Font(CTFont(.label, size: 48)))
                .bold()

            Spacer()
            
            VStack(alignment: .leading) {
                Text("Email")
                    .font(.title2)
                
                TextField("Email", text: $viewModel.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .submitLabel(.next)
                    .focused($focusedField, equals: .username)
            }.padding(.horizontal, 40)
            
            VStack(alignment: .leading) {
                Text("Password")
                    .font(.title2)
                
                SecureField("Enter a password", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .submitLabel(.done)
                    .focused($focusedField, equals: .password)
                
                Text(error_text)
                    .font(.footnote)
                    .foregroundStyle(.red)
                
            }.padding(.horizontal, 40)
            
            Spacer()
            
            Button {
                Task {
//                    do {
//                        try await viewModel.signUp()
//                        showSignInView = false
//                    } catch {
//                        print("error")
//                    }
                    do {
                        try await viewModel.signIn()
                        showSignInView = false
                    } catch {
                        error_text = "incorrect username or password"
                        print("error")
                    }
                }
            } label: {
                GreenButtonView(text: "Submit")
            }
            
            Button {
                Task {
                    do {
                        try await viewModel.signInAnonymously()
                        showSignInView = false
                    } catch {
                        error_text = "unknown error"
                        print("guest login error")
                    }
                }
            } label: {
                Text("Log in as guest")
                    .foregroundStyle(.dark)
            }
            
        }
        .navigationBarBackButtonHidden()
        .onSubmit {
            if focusedField == .username {
                focusedField = .password
            } else {
                focusedField = nil
            }
        }
    }
}




#Preview {
    LogInView(showSignInView: .constant(false))
}
