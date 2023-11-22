//
//  Reminders.swift
//  Drink Water
//
//  Created by Anton Rasen on 17.11.2023.
//

import SwiftUI

struct Reminders: View {
    @State private var remindersOn = true
    @State private var soundOn = true
    
    let notify = NotificationHandler()
    
    var body: some View {
        
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            VStack {
                
                Text("Напоминания")
                    .padding(.vertical, 8.0)
                    .foregroundStyle(.cyan)
                    .font(.system(size: 25))
                
                VStack {
                    
                    Toggle("Напоминания Вкл/Выкл", isOn: $remindersOn)
                        .foregroundStyle(.cyan)
                        .toggleStyle(SwitchToggleStyle(tint: .cyan))
                    
                    Divider()
                        .overlay(.cyan)
                    
                    Toggle("Звук", isOn: $soundOn)
                        .foregroundStyle(.cyan)
                        .toggleStyle(SwitchToggleStyle(tint: .cyan))
                    
                    
                    
                }
                .padding()
                .frame(width: 350.0, height: 100)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.cyan, lineWidth: 2)
                )
                
                HStack {
                    
                    NavigationLink(destination: AddReminders()) {
                        Text("Добавить напоминание")
                            .foregroundStyle(.cyan)
                            .font(.system(size: 20))
                        Image(systemName: "plus.circle")
                            .foregroundStyle(.cyan)
                            .font(.system(size: 25))
                        
                        
                    }
                    .padding()
                    .frame(width: 350.0, height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.cyan, lineWidth: 2)
                    )               
                }
                
                Spacer()
                Text("Если не работает")
                    .foregroundStyle(.cyan)
                    .italic()
                
                Image(systemName: "arrow.down")
                    .foregroundStyle(.cyan)
                
                Button {
                    notify.askPermission()
                } label: {
                    Text("Включить разрешение")
                        .foregroundStyle(.cyan)
                }
            }
        }
    }
}

#Preview {
    Reminders()
}
