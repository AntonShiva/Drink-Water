//
//  Reminders.swift
//  Drink Water
//
//  Created by Anton Rasen on 17.11.2023.
//

import SwiftUI
import CustomAlert
import UserNotifications


struct Reminders: View {
    @EnvironmentObject var lnManager: LocalNotificationManager
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.presentationMode) var presentationMode
    @State private var scheduleDate = Date()
    
    @State private var remindersOn = true
    @State private var soundOn = true
    
    @State private var isOn = true
    
    
    
    @State private var showFancy = false
    @State var selectedDate = Date()
    
    
    var body: some View {
        
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            VStack {
                if lnManager.isGranted {
                    
                    VStack {
                    
                        Text("Напоминания")
                            .padding(.vertical, 8.0)
                            .foregroundStyle(.cyan)
                            .font(.system(size: 25))
                        
                    }
                    
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
                        .frame(width: 340.0, height: 50)
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
                                
                                DatePicker("", selection: $scheduleDate, displayedComponents: .hourAndMinute)
                                
                                    .background(LinearGradient(gradient: Gradient(colors: [Color.cyan, Color.vtoroi]), startPoint: .top, endPoint: .bottom))
                                    .colorScheme(.dark)
                                
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
                                    Task {
                                        
                                        // получение времение из dateComponents
                                        
                                        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: scheduleDate)
                                        let stringDate = scheduleDate
                                        let dateString2 = String("\(stringDate)")
                                        let dateFormatter = DateFormatter()
                                        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss z"
                                        dateFormatter.locale = Locale.init(identifier: "en_US_POSIX")
                                        let dateObj = dateFormatter.date(from: dateString2)
                                        dateFormatter.dateFormat = "HH:mm"
                                        let vremia = dateFormatter.string(from: dateObj!)
                                        
                                        //                                    _____________________________________________
                                        // Создане напроминания
                                        let localNotification = LocalNotification(identifier: UUID().uuidString,
                                                                                  title: "Пора пить воду!",
                                                                                  body: vremia,
                                                                                  dateComponents: dateComponents,
                                                                                  repeats: true)
                                        await lnManager.schedule(localNotification: localNotification)
                                    }
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
                    
                    // список напоминаний
                    VStack {
                        List {
                            ForEach(lnManager.pendingRequests.sorted(by: { $0.content.body < $1.content.body }), id: \.identifier) { request in
                                
                                HStack{
                                    Image(systemName: "alarm")
                                        .padding(.leading, 5.0)
                                        .foregroundStyle(.cyan)
                                        .font(.system(size: 22))
                                    
                                    Text("-  \(request.content.body)")
                                        .foregroundStyle(.cyan)
                                        .font(.system(size: 22))
                                    
                                    Spacer()
                                    
                                    // РАЗОБРАТЬСЯ почему активно все поле удаление нажно что бы только кнопка ! ______________
                                    Button { lnManager.removeRequest(withIdentifier: request.identifier)
                                    } label: {
                                        HStack {
                                            Text("Удалить")
                                                .foregroundStyle(.white)
                                                .font(.system(size: 20))
                                        }
                                        .frame(width: 100, height: 35)
                                        .background(.cyan)
                                        .cornerRadius(10)
                                        .padding(.trailing, 2.0)
                                        
                                    }
                                }
                                .padding()
                                .frame(width: 340.0, height: 48)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.cyan, lineWidth: 2)
                                )
                                
                                .swipeActions(edge: .trailing) {
                                    Button { lnManager.removeRequest(withIdentifier: request.identifier)
                                    } label: {
                                        Text("Удалить")
                                    }
                                    .tint(.cyan)
                                }
                            }
                            .padding(.top, 1.0)
                            .tint(.cyan)
                            
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                        }
                        .scrollContentBackground(.hidden)
                        
                        Spacer()
                        
                    }
                } else {
                    VStack {
                        Button {
                            lnManager.openSettings()
                        } label: {
                            Text("Разрешить уведомления")
                                .foregroundStyle(.cyan)
                                .font(.system(size: 20))
                        }
                        .frame(width: 350.0, height: 50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.cyan, lineWidth: 2)
                        )
                        .padding(70)
                        Spacer()
                    }
                }
            }
            .onChange(of: scenePhase) { newValue in
                if newValue == .active {
                    Task {
                        await lnManager.getCurrentSettings()
                        await lnManager.getPendingRequests()
                    }
                }
            }
        }
        
    }
    
}

#Preview {
    Reminders()
        .environmentObject(LocalNotificationManager())
}
