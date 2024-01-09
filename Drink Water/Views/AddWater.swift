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
    
    @Query var pol: [Pol]
    
    @Query var dailyWaterConsumption: [DailyWaterConsumption]
  
  
    @Query var waterConsumptionByDate: [WaterConsumptionByDate]
    
   
    
    // wave
    @State private var percet = 0.0
    @State private var waveOffset = Angle(degrees: 0)
    @State private var waveOffset2 = Angle(degrees: 180)
    
    
    // picker
    var ml = [100, 150, 200, 250, 300]
    @State private var selectedML = 200
   
    
    
    @State private var isPresented = false
    
    // amount of water per day - daily rate
    @AppStorage("dailyRate")  var dailyRate = 1800
    
    @Query var dailyRateSave: [DailyRate]
    
    @State private var date = Date()
    
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
                  
                   if let existingIndex = dailyWaterConsumption.firstIndex(where: { $0.date.formatted(date: .complete, time: .omitted) == date.formatted(date: .complete, time: .omitted) }) {
                       
                       Text("\(dailyWaterConsumption[existingIndex].totalWaterConsumed) мл.")
                           .padding(.top, 20.0)
                           .foregroundStyle(Color.cyan)
                           .font(.title)
                           .onAppear(perform: {
                               
                               let daily: Double = Double(self.dailyRate)
                               let total: Double = Double(dailyWaterConsumption[existingIndex].totalWaterConsumed)
                               
                               let chislo: Double = Double( daily / total)
                               let procent: Double = Double( 100 / chislo)
                              
                               percet = procent
                           })
                       
                     } else {
                       Text("\(0) мл.")
                           .padding(.top, 20.0)
                           .foregroundStyle(Color.cyan)
                           .font(.title)
                   }
                   
                   
                   //             MARK: Man and wave
                   
                   VStack {
                       ZStack(alignment: .center) {
                           Rectangle()
                               .fill(Color.manColor.opacity(0.8))
                               .frame(width: 250, height: 350)
                           
                           Wave(offset: Angle(degrees: self.waveOffset.degrees), percent: percet / 95.0)
                               .fill(Color.cyan)
                               .frame(width: 250, height: 360)
                               .offset(x: -30, y: 15)
                           
                           Wave(offset: Angle(degrees: self.waveOffset2.degrees), percent: percet / 95.0)
                               .fill(Color.cyan)
                               .opacity(0.5)
                               .frame(width: 250, height: 360)
                               .offset(x: 5, y: 15)
                       }
                       .onAppear {
                           withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                               self.waveOffset = Angle(degrees: 360)
                               self.waveOffset2 = Angle(degrees: -180)
                           }

                       }
                       
                       .mask {
                                               if !pol.isEmpty {
                                                   Image(   pol[0].pol ? "man" : "woman" )
                                                       .resizable()
                                                       .aspectRatio(contentMode: .fit)
                                                       .frame(width: 250, height: 350)
                                               } else {
                                                  Image("man")
                                                       .resizable()
                                                       .aspectRatio(contentMode: .fit)
                                                       .frame(width: 250, height: 350)
                                               }
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
                               
                               let date = Date()
                               
                               // вермя
                               let timeFormatter = DateFormatter()
                               timeFormatter.dateFormat = "HH:mm"
                               let timeString = timeFormatter.string(from: date)
                               if let existingIndex = dailyWaterConsumption.firstIndex(where: { $0.date.formatted(date: .complete, time: .omitted) == date.formatted(date: .complete, time: .omitted) }) {
                                   dailyWaterConsumption[existingIndex].totalWaterConsumed += selectedML
                                   
                                   let daily: Double = Double(self.dailyRate)
                                   let total: Double = Double(dailyWaterConsumption[existingIndex].totalWaterConsumed)
                                   
                                   let chislo: Double = Double( daily / total)
                                   let procent: Double = Double( 100 / chislo)
                                   percet = procent
                                   
                               } else {
                                   let newConsumption = DailyWaterConsumption(totalWaterConsumed: selectedML, date: date)
                                   
                                   let daily: Double = Double(self.dailyRate)
                                   let selected: Double = Double(selectedML)
                                   let chislo: Double = daily / selected
                                  let procent = Double( 100 / chislo)
                                   percet = procent
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
                                   if dailyRateSave.isEmpty {
                                       let chislo = DailyRate(dailyRate: self.dailyRate)
                                       context.insert(chislo)
                                   } else {
                                       dailyRateSave[0].dailyRate = self.dailyRate
                                   }
                               }
                           } label: {
                               Image(systemName: "minus.circle")
                                   .foregroundStyle(.cyan)
                                   .font(.system(size: 30))
                           }
                           
                           if !dailyRateSave.isEmpty {
                               Text("\(dailyRateSave[0].dailyRate)")
                                   .onChange(of: dailyRateSave[0].dailyRate) { newValue in
                                       if let existingIndex = dailyWaterConsumption.firstIndex(where: { $0.date.formatted(date: .complete, time: .omitted) == date.formatted(date: .complete, time: .omitted) }) {
                                           
                                           let daily: Double = Double(newValue)
                                           let total: Double = Double(dailyWaterConsumption[existingIndex].totalWaterConsumed)
                                           
                                           let chislo: Double = Double( daily / total)
                                           let procent: Double = Double( 100 / chislo)
                                           percet = procent
                                           
                                       }
                                     }
                                   .foregroundStyle(.cyan)
                                   .font(.system(size: 28))
                           } else {
                               
                               Text("\(1800)")
                                   .foregroundStyle(.cyan)
                                   .font(.system(size: 28))
                           }
                           
                           
                           Button {
                               
                               self.dailyRate += 100
                               if dailyRateSave.isEmpty {
                                   let chislo = DailyRate(dailyRate: self.dailyRate)
                                   context.insert(chislo)
                               } else {
                                   dailyRateSave[0].dailyRate = self.dailyRate
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
