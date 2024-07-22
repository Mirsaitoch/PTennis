//
//  CTF.swift
//  PTennis
//
//  Created by Мирсаит Сабирзянов on 22.07.2024.
//

import Foundation
import SwiftUI

public struct CustomTF: View {
    @Binding var text:String
    @State var placeholder:String
    @State var ImageTF : Image?
    @State var isPassword:Bool
    @State var StylesType:StylesEnum
    @State var KeyboardType : UIKit.UIKeyboardType
    @State var color : Color?
    @Environment(\.colorScheme) private var colorScheme
    public init(text: Binding<String>, placeholder: String, ImageTF: Image?, isPassword: Bool, StylesType: StylesEnum, KeyboardType: UIKit.UIKeyboardType,color: Color?) {
        self._text = text
        self._placeholder = State(initialValue:placeholder)
        self._ImageTF = State(initialValue:ImageTF)
        self._isPassword = State(initialValue:isPassword)
        self._StylesType = State(initialValue:StylesType)
        self._KeyboardType = State(initialValue:KeyboardType)
        self._color = State(initialValue: color)
    }
    public var body: some View {
        if self.StylesType == .Style1 {
            Style1
        } else if self.StylesType == .Style2 {
            Style2
        } else if self.StylesType == .Style3 {
            Style3
        } else if self.StylesType == .Style4 {
            Style4
        }
    }
    public var Style1: some View {
        ZStack {
            HStack {
                if ImageTF != nil {
                    withAnimation(.easeInOut) {
                        ImageTF
                            .foregroundColor(self.color == nil ? (self.colorScheme == .light ? Color.black : Color.white) : color)
                            .scaleEffect(text.isEmpty ? 1 : 1.2)
                            .animation(.easeInOut)
                    }
                }
                if isPassword {
                    SecureField(placeholder , text: $text)
                        .keyboardType(self.KeyboardType)
                } else {
                    TextField(placeholder , text: $text)
                        .keyboardType(self.KeyboardType)
                }
            }.padding(.horizontal).frame(maxWidth:.infinity , minHeight:45, maxHeight: 45)
                .overlay(RoundedRectangle(cornerRadius: 15).stroke())
        }
    }
    public var Style2: some View {
        ZStack {
            HStack {
                if ImageTF != nil {
                    withAnimation(.easeInOut) {
                        ImageTF
                            .foregroundColor(self.color == nil ? Color.white : color)
                            .scaleEffect(text.isEmpty ? 1 : 1.2)
                            .animation(.easeInOut)
                    }
                }
                if isPassword {
                    SecureField(placeholder , text: $text)
                        .foregroundStyle(.white)
                        .keyboardType(self.KeyboardType)
                } else {
                    TextField(placeholder , text: $text)
                        .foregroundStyle(.white)
                        .keyboardType(self.KeyboardType)
                }
            }.padding(.horizontal).frame(maxWidth:.infinity , minHeight:45, maxHeight: 45)
            ZStack { RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 2)
                    .frame(maxWidth:.infinity , minHeight:45, maxHeight: 45)
                Text(placeholder)
                    .foregroundStyle(.white)
                    .bold()
                    .padding(.horizontal,5)
                    .background(self.color == nil ? Color.bcolor : color)
                    .frame(maxWidth:.infinity , minHeight:65, maxHeight: 65,alignment: .topLeading)
                    .padding(.leading , 35)
            }.frame(maxWidth:.infinity , minHeight:45, maxHeight: 45)
        }.frame(maxWidth:.infinity , minHeight:65, maxHeight: 65)
    }
    public var Style3: some View {
        ZStack {
            HStack {
                if ImageTF != nil {
                    withAnimation(.easeInOut) {
                        ImageTF
                            .foregroundColor(self.color == nil ? (self.colorScheme == .dark ? Color.black : Color.white) : color)
                            .scaleEffect(text.isEmpty ? 1 : 1.2)
                            .animation(.easeInOut)
                    }
                }
                if isPassword {
                    SecureField(placeholder , text: $text)
                        .keyboardType(self.KeyboardType)
                } else {
                    TextField(placeholder , text: $text)
                        .keyboardType(self.KeyboardType)
                }
                Button {
                    self.text.removeAll()
                } label: {
                    Image(systemName: "xmark")
                        .font(.title2)
                        .foregroundColor(self.color == nil ? (self.colorScheme == .dark ? Color.white : Color.black) : color)
                }
                
            }.padding(.horizontal).frame(maxWidth:.infinity , minHeight:45, maxHeight: 45)
            ZStack { RoundedRectangle(cornerRadius: 8).stroke((self.color == nil ? (self.colorScheme == .dark ? Color.white : Color.black) : color)!,lineWidth: 2)
                    .shadow(color: ((self.color == nil ? (self.colorScheme == .dark ? Color.white : Color.black) : color)!).opacity(0.4), radius: 5, x: 0, y: 0)
                    .frame(maxWidth:.infinity , minHeight:45, maxHeight: 45)
                Text(placeholder)
                    .foregroundColor(self.color == nil ? (self.colorScheme == .dark ? Color.white : Color.black) : color)
                    .bold()
                    .padding(.horizontal,5)
                    .background(self.colorScheme == .dark ? Color.black : Color.white)
                    .frame(maxWidth:.infinity , minHeight:65, maxHeight: 65,alignment: .topLeading)
                    .padding(.leading , 35)
            }.frame(maxWidth:.infinity , minHeight:45, maxHeight: 45)
        }.frame(maxWidth:.infinity , minHeight:65, maxHeight: 65)
        
    }
    public var Style4: some View {
        ZStack {
            
            HStack {
                if ImageTF != nil {
                    withAnimation(.easeInOut) {
                        ImageTF
                            .foregroundColor(self.color == nil ? (self.colorScheme == .dark ? Color.black : Color.white) : color)
                            .scaleEffect(text.isEmpty ? 1 : 1.2)
                            .animation(.easeInOut)
                    }
                }
                if isPassword {
                    SecureField(placeholder , text: $text)
                        .keyboardType(self.KeyboardType)
                } else {
                    TextField(placeholder , text: $text)
                        .keyboardType(self.KeyboardType)
                }
                Button {
                    self.text.removeAll()
                } label: {
                    Image(systemName: "xmark")
                        .font(.title2)
                        .foregroundColor(self.color == nil ? (self.colorScheme == .dark ? Color.white : Color.black) : color)
                }
                
            }.padding(.horizontal).frame(maxWidth:.infinity , minHeight:45, maxHeight: 45)
            ZStack { RoundedRectangle(cornerRadius: 30).stroke(((self.color == nil ? (self.colorScheme == .dark ? Color.white : Color.black) : color)!),lineWidth: 2)
                    .shadow(color: ((self.color == nil ? (self.colorScheme == .dark ? Color.white : Color.black) : color)!).opacity(0.4), radius: 5, x: 0, y: 0)
                    .frame(maxWidth:.infinity , minHeight:45, maxHeight: 45)
                Text(placeholder)
                    .foregroundColor(self.color == nil ? (self.colorScheme == .dark ? Color.white : Color.black) : color)
                    .bold()
                    .padding(.horizontal,5)
                    .background(self.colorScheme == .dark ? Color.black : Color.white)
                    .frame(maxWidth:.infinity , minHeight:65, maxHeight: 65,alignment: .topLeading)
                    .padding(.leading , 35)
            }.frame(maxWidth:.infinity , minHeight:45, maxHeight: 45)
        }.frame(maxWidth:.infinity , minHeight:65, maxHeight: 65)
        
    }
}

public enum StylesEnum {
    case Style1
    case Style2
    case Style3
    case Style4
}
