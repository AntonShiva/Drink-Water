//
//  AddWater.swift
//  Drink Water
//
//  Created by Anton Rasen on 10.11.2023.
//

import SwiftUI
import SwiftData

struct AddWater: View {
    // сохранение истории
    // СвифтДата
    @Environment(\.modelContext) var context
   
    @Query var dailyWaterConsumption: [DailyWaterConsumption]
    @AppStorage("count")  var count = 0
    @Query var countHistory: [HistoryCount]
    @Query var waterConsumptionByDate: [WaterConsumptionByDate]
    
    // wave
    @State private var percet = 0.0
    @State private var waveOffset = Angle(degrees: 0)
    @State private var waveOffset2 = Angle(degrees: 180)
    
    
    // picker
    var ml = [100, 150, 200, 250, 300]
    @State private var selectedML = 200
    //    @AppStorage("waterCount")
    @State private var waterCount = 0
    
    @State private var isPresented = false
    
    // amount of water per day - daily rate
    @AppStorage("dailyRate")  var dailyRate = 1800
    
   
    
    // initializer of colors for the picker
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor =  #colorLiteral(red: 0.2642083466, green: 0.7893971801, blue: 1, alpha: 1)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    }
    
    var body: some View {
        
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            VStack {
                
                // MARK: заменить это на данные из DailyWaterConsumption 
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
                       
                                   // вермя
                                   let timeFormatter = DateFormatter()
                                   timeFormatter.dateFormat = "HH:mm"
                                   let timeString = timeFormatter.string(from: date)
                           
                                    
                                    if let existingIndex = dailyWaterConsumption.firstIndex(where: { $0.date.formatted(date: .complete, time: .omitted) == date.formatted(date: .complete, time: .omitted) }) {
                                        dailyWaterConsumption[existingIndex].totalWaterConsumed += selectedML
                                        print(count)

                                    } else {
                                        let newConsumption = DailyWaterConsumption(totalWaterConsumed: selectedML, date: date)
                                        count += 1
                                        let countHistory = HistoryCount.init(count: count)
                                        context.insert(countHistory)
                                        context.insert(newConsumption)
                                    }
  
                                                    

                            if let index = waterConsumptionByDate.firstIndex(where: { $0.date.formatted(date: .complete, time: .omitted) == date.formatted(date: .complete, time: .omitted) }) {
                                waterConsumptionByDate[index].porcaica.append(selectedML)
                                waterConsumptionByDate[index].vremia.append(timeString)
                                
                            } else {
                                let consumption = WaterConsumptionByDate(date: date, vremia: [timeString], porcaica: [selectedML])
                                context.insert(consumption)
                                
                            }
                            
                            
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
                        
                       
                            Text("\(self.dailyRate) мл.")
                                .foregroundStyle(.cyan)
                                .font(.system(size: 28))
                        

                        
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
    
}
