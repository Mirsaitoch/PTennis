//
//  PTennisApp.swift
//  PTennis
//
//  Created by Мирсаит Сабирзянов on 05.04.2024.
//

import SwiftUI
import FirebaseCore
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct PTennisApp: App {
    
    @AppStorage("isLoggedIn") var isLogin = false
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @ObservedObject var appViewModel = AppViewModel()
    
    init() {
        if isLogin {
            appViewModel.isLogin = true
        }
    }
    
    var body: some Scene {
        WindowGroup {
            if appViewModel.isLogin {
                ContentView()
                    .environmentObject(appViewModel)
                
            } else {
                LogInView()
                    .environmentObject(appViewModel)
            }
        }
    }
}
