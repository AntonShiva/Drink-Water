//
//  AddReminders.swift
//  Drink Water
//
//  Created by Anton Rasen on 22.11.2023.
//

import SwiftUI

struct AddReminders: View {
    @State var selectedDate = Date()
    
  
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            VStack {
                
                Text("Выберите врем")
                    .padding(.vertical, 8.0)
                    .foregroundStyle(.cyan)
                    .font(.system(size: 25))
                
                DatePicker("", selection: $selectedDate, displayedComponents: .hourAndMinute)
                    
                    .background(LinearGradient(gradient: Gradient(colors: [Color.cyan, Color.blue]), startPoint: .top, endPoint: .bottomTrailing))
                    .colorScheme(.light)
                    .accentColor(.white)
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .cornerRadius(300)
                    .frame(width: 300.0, height: 150)
                 
                
                    .padding()
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(Color.cyan, lineWidth: 2)
                    )
                
                Spacer()
                
                Button("Сохранить") {
                    
                }
                
            }
            
            
        }
    }
}

#Preview {
    AddReminders()
}
