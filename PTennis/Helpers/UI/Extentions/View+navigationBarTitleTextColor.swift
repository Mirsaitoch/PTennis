//
//  View+navigationBarTitleTextColor.swift
//  PTennis
//
//  Created by Мирсаит Сабирзянов on 22.07.2024.
//

import Foundation
import SwiftUI

extension View {
    @available(iOS 14, *)
    func navigationBarTitleTextColor(_ color: Color) -> some View {
        let uiColor = UIColor(color)
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: uiColor ]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: uiColor ]
        return self
    }
}
