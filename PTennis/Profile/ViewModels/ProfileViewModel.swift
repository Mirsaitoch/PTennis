//
//  ProfileViewModel.swift
//  PTennis
//
//  Created by Мирсаит Сабирзянов on 22.04.2024.
//

import Combine
import Foundation
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI


@MainActor
final class ProfileViewModel: ObservableObject {
       
    func logOut() throws {
        try AuthManager.shared.signOut()
    }
}

