//
//  CustomTabBar.swift
//  PTennis
//
//  Created by Мирсаит Сабирзянов on 21.04.2024.
//

import SwiftUI

struct CustomTabBar: View {
    
    @Binding var selectedTab: String
    @State var tapPoints: [CGFloat] = []
    
    var body: some View {
        HStack(spacing: 0) {
            TabBarButton(image: "tennis.racket.circle", selectedTab: $selectedTab, tabPoints: $tapPoints)
            
            TabBarButton(image: "trophy", selectedTab: $selectedTab, tabPoints: $tapPoints)
            
            TabBarButton(image: "person", selectedTab: $selectedTab, tabPoints: $tapPoints)

        }
        .padding()
        .background(Color
            .lightGreen
            .clipShape(TabCurve(tabPoint: getCurvePoints() - 15)))
        .cornerRadius(20.0)
        .padding(.horizontal)
        .overlay (
            Image(systemName: "tennisball.fill")
                .foregroundStyle(.lightGreen)
                .frame(width: 10, height: 10)
                .offset(x: getCurvePoints() - 3)
            ,alignment: .bottomLeading
        )
    }
    
    func getCurvePoints() -> CGFloat {
        if tapPoints.isEmpty {
            return 10
        }
        else {
            switch selectedTab {
            case "tennis.racket.circle":
                return tapPoints[0]
            case "trophy":
                return tapPoints[1]
            case "person":
                return tapPoints[2]
            default:
                return tapPoints[0]
            }
        }
    }
}

#Preview {
    CustomTabBar(selectedTab: .constant("tennis.racket.circle"))
}

struct TabBarButton: View {
    var image: String
    @Binding var selectedTab: String
    @Binding var tabPoints: [CGFloat]
    
    var body: some View {
        GeometryReader { proxy -> AnyView in
            
            let midX = proxy.frame(in: .global).midX
            
            DispatchQueue.main.async {
                if tabPoints.count <= 3 {
                    tabPoints.append(midX)
                }
            }
            
            return AnyView(
                Button(action: {
                    withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.5)) {
                        selectedTab = image
                    }
                }, label: {
                    VStack {
                        Image(systemName: "\(image)\(selectedTab == image ? ".fill" : "")")
                            .font(.system(size: 25, weight: .semibold))
                            .foregroundStyle(.dark)
                            .offset(y: selectedTab == image ? -10 : 0)
                    }
                })
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            )
        }
        .frame(height: 50)
    }
}
