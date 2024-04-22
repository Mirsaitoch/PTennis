//
//  CustomDatePicker.swift
//  PTennis
//
//  Created by Мирсаит Сабирзянов on 22.04.2024.
//

import SwiftUI

struct CustomDatePicker: View {
  @Binding var date: Date

  @State private var showPicker: Bool = false
  @State private var selectedDateText: String = "Date"

  private var selectedDate: Binding<Date> {
    Binding<Date>(get: { self.date}, set : {
        self.date = $0
        self.setDateString()
    })
  } // This private var I found… somewhere. I wish I could remember where

  // To take the selected date and store it as a string for the text field
  private func setDateString() {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM dd, yyyy"

    self.selectedDateText = formatter.string(from: self.date)
  }

  var body: some View {
    VStack {
        HStack {
            Text("Date:")
                .frame(alignment: .leading)
            
            TextField("", text: $selectedDateText)
                .onAppear() {
                    self.setDateString()
                }
                .disabled(true)
                .onTapGesture {
                    self.showPicker.toggle()
                }
            .multilineTextAlignment(.trailing)
        }
        
        if showPicker {
            DatePicker("", selection: selectedDate,
            displayedComponents: .date)
            .datePickerStyle(WheelDatePickerStyle())
            .labelsHidden()
        }
    }
  }
}
