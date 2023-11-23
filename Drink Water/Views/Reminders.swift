//
//  Reminders.swift
//  Drink Water
//
//  Created by Anton Rasen on 17.11.2023.
//

import SwiftUI
import CustomAlert
struct Reminders: View {
    @State private var remindersOn = true
    @State private var soundOn = true
    
    let notify = NotificationHandler()
    
    @State private var showFancy = false
    @State var selectedDate = Date()
    
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
                    
                    Button {
                        showFancy = true
                    } label: {
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
                    .customAlert(isPresented: $showFancy) {
                        VStack {
                            HStack {
                                Image("jane")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                
                               Image(systemName: "alarm")
                                    .foregroundStyle(.svetloCyan)
                                    .font(.system(size: 28))
                            }
                                Text("Выберите время")
                                .font(.title2)
                                .padding(.bottom, 10.0)
                                .foregroundStyle(.svetloCyan)
                            
                            DatePicker("", selection: $selectedDate, displayedComponents: .hourAndMinute)
                            
                                .background(LinearGradient(gradient: Gradient(colors: [Color.cyan, Color.vtoroi]), startPoint: .top, endPoint: .bottom))
                                .colorScheme(.dark)
            //                    .accentColor(.white)
                                .datePickerStyle(.wheel)
                                .labelsHidden()
                                .cornerRadius(50)
                                .frame(width: 250.0, height: 150)
                            
                            
                                .padding()
                                .cornerRadius(50)
         
                        }
                       
                        
                        .background(Color.cyan)
                        .cornerRadius(10)
                    } actions: {
                        MultiButton {
                            Button(role: .cancel) {
                                
                            } label: {
                                Text("Отменить")
                                    .font(.title2)
                            }
                           
                            
                            Button {
                                
                            } label: {
                                Text("Сохранить")
                                    .font(.title2)
                            }
                        }
                        
                    }
                    .environment(\.customAlertConfiguration, .create { configuration in
                        configuration.background = .blurEffect(.dark)
                        configuration.padding = EdgeInsets()
                        configuration.alert = .create { alert in
                            alert.background = .color(.cyan)
                            alert.cornerRadius = 20
                            alert.padding = EdgeInsets(top: 10, leading: 20, bottom: 20, trailing: 20)
                            alert.minWidth = 300
            //                alert.titleFont = .headline
            //                alert.contentFont = .subheadline
                            alert.alignment = .leading
                            alert.spacing = 10
                        }
                        configuration.button = .create { button in
                            button.tintColor = .svetloCyan
                            button.padding = EdgeInsets(top: 0, leading: 10, bottom: 20, trailing: 10)
                            button.font = .callout.weight(.semibold)
                            button.hideDivider = true
                        }
                    })
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
