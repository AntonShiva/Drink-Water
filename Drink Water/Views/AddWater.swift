//
//  AddWater.swift
//  Drink Water
//
//  Created by Anton Rasen on 10.11.2023.
//

import SwiftUI

struct AddWater: View {
    // сохранение истории
     @EnvironmentObject var history: HistoryClass
     @State private var historyDate = Date()
    
    // wave
    @State private var percet = 0.0
    @State private var waveOffset = Angle(degrees: 0)
    @State private var waveOffset2 = Angle(degrees: 180)
    
    
    // picker
    var ml = [100, 150, 200, 250, 300]
    @State private var selectedML = 200
    @State private var waterCount = 0
    
    @State private var isPresented = false
    
    // amount of water per day - daily rate
    @State private var dailyRate = 1800
    
    
    
    // initializer of colors for the picker
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = #colorLiteral(red: 0.2642083466, green: 0.7893971801, blue: 1, alpha: 1)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    }
    
    var body: some View {
        
            ZStack {
                Color.background
                    .ignoresSafeArea()
                
                VStack {
                
                    
                    Cel(waterCount: $waterCount)
                    
                    //             MARK: Man and wave
                    
                    VStack {
                        ZStack(alignment: .center) {
                            Rectangle()
                                .fill(Color.manColor.opacity(0.8))
                                .frame(width: 300, height: 400)
                            
                            Wave(offset: Angle(degrees: self.waveOffset.degrees), percent: percet / 95.0)
                                .fill(Color.cyan)
                                .frame(width: 300, height: 410)
                                .offset(x: -30, y: 8)
                            
                            Wave(offset: Angle(degrees: self.waveOffset2.degrees), percent: percet / 95.0)
                                .fill(Color.cyan)
                                .opacity(0.5)
                                .frame(width: 300, height: 410)
                                .offset(x: 5, y: 8)
                        }
                        .onAppear {
                            withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                                self.waveOffset = Angle(degrees: 360)
                                self.waveOffset2 = Angle(degrees: -180)
                            }
                        }
                        
                        .mask {
                            Image("man")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 300, height: 400)
                            
                        }
                    }
                    //_____________________________________________
                    
                    Spacer()
                        .frame(height: 5)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Выбери порцию в мл.")
                                .foregroundStyle(.cyan)
                                .font(.system(size: 19))
                                .frame(width: 200.0)
                            
                            Picker("Picker", selection: $selectedML) {
                                ForEach(ml, id: \.self) {
                                    Text("\($0)")
                                }
                            }
                            .pickerStyle(PalettePickerStyle())
                            .background(LinearGradient(gradient: Gradient(colors: [Color.cyan, Color.blue]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(7)
                            .frame(width: 205)
                        }
                        
                        HStack {
                            Image(systemName: "plus")
                                .foregroundStyle(.cyan)
                            
                            Button {
                                if self.waterCount < self.dailyRate {
                                    let chislo = self.dailyRate / selectedML
                                    percet += Double(100 / chislo)
                                }
                                    self.waterCount += selectedML
                                    
                                    let date = Date()
                                   
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.locale = Locale.current
                                    dateFormatter.timeZone = TimeZone.current
                                    dateFormatter.locale = Locale(identifier: "ru_RU_POSIX")
                                    dateFormatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ssZ"
                                    
                                     let dateString = dateFormatter.string(from: date)
                                  
                                    
                                    if let dateDate = dateFormatter.date(from: dateString) {
                                        // создание формата для dailyConsumptions и передачу в график
                                        let dateDailyConsumptions = Date()
                                        let formatter = DateFormatter()
                                        formatter.dateFormat = "yyyyMMdd"
                                        let datedailyConsumptionsStrin = formatter.string(from: dateDailyConsumptions)
                                  print(datedailyConsumptionsStrin)
                                        if let datedailyConsumptionsDate = formatter.date(from: datedailyConsumptionsStrin) {
                                            print(datedailyConsumptionsDate)
                                            history.addWaterConsumption(amount: selectedML, date: datedailyConsumptionsDate)
                                        }
                                        let stepCount = HistoryStruct(weekday: dateString, porcia: selectedML, date: dateDate)
                                        history.history.append(stepCount)
                                       
                                    }
                                    
//                                            history.addItem(item: selectedML, date: dateString)
//                                    print(history.history)
//                                    print(history.dailyConsumptions)
//                                    let dateComponents = Calendar.current.dateComponents([.month, .day, .year], from: historyDate)
//                                           if let date = Calendar.current.date(from: dateComponents) {
                                    
//                                    if let existingIndex = history.dailyConsumptions.firstIndex(where: { $0.date == dateString }) {
//                                        history.dailyConsumptions[existingIndex].totalWaterConsumed += selectedML
//                                    } else {
//                                        let newConsumption = DailyWaterConsumption(date: dateString, totalWaterConsumed: selectedML)
//                                        history.dailyConsumptions.append(newConsumption)
//                                    }
//                                               history.addWaterConsumption(amount: selectedML, date: dateString)
//                                           }
                                    
                                    // получение времение из historyDate
//                                    let dateComponents = Calendar.current.dateComponents([
//                                        .month, .hour, .minute], from: historyDate)
//                                    let stringDate = historyDate
//                                    let dateString2 = String("\(stringDate)")
//                                    let dateFormatter = DateFormatter()
//                                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss z"
//                                    dateFormatter.locale = Locale.init(identifier: "ru_RU")
//                                    let dateObj = dateFormatter.date(from: dateString2)
//                                    dateFormatter.dateFormat = "HH:mm"
//                                    let vremia = dateFormatter.string(from: dateObj!)
                                    
//                                    history.addTime(time: vremia)
//                                    
//                                    history.addItem(item: String(selectedML))
//                                    
//                                    print(history.dailyConsumptions)
//                                    print(history.time)
                                    
                                
                            } label: {
                                Image("glass1")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            }
                        }
                        
                    }
                    .padding()
                    .frame(width: 320.0, height: 80)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.cyan, lineWidth: 2)
                    )
                    
                    Spacer()
                        .frame(height: 15)
                    
                    VStack(spacing: 5.0) {
                        Text("Выбери свою дневную норму")
                            .foregroundStyle(.cyan)
                            .font(.system(size: 18))
                        HStack {
                            
                            Button {
                                if self.dailyRate > 0 {
                                    self.dailyRate -= 100
                                }
                            } label: {
                                Image(systemName: "minus.circle")
                                    .foregroundStyle(.cyan)
                                    .font(.system(size: 30))
                            }
                            
                            DailyNorm(dailyRate: $dailyRate)
                            
                            Button {
                                if self.dailyRate < 3000 {
                                    self.dailyRate += 100
                                }
                            } label: {
                                Image(systemName: "plus.circle")
                                    .foregroundStyle(.cyan)
                                    .font(.system(size: 30))
                            }
                        }
                    }
                    .padding()
                    .frame(width: 320.0, height: 80)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.cyan, lineWidth: 2)
                    )
                    
                }
                .padding(.top, 50)
            }
        
        .accentColor(.cyan)
    }
}

#Preview {
    AddWater()
        .environmentObject(HistoryClass())
}
