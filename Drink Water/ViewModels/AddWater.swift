//
//  AddWater.swift
//  Drink Water
//
//  Created by Anton Rasen on 10.11.2023.
//

import SwiftUI
import SwiftData


struct AddWater: View {
    // Свойства для работы с данными
    @Environment(\.modelContext) var context
    @Query var pol: [Pol]
    @Query var dailyWaterConsumption: [DailyWaterConsumption]
    @Query var waterConsumptionByDate: [WaterConsumptionByDate]
    @Query var dailyRateSave: [DailyRate]

    // Свойства для анимации волн
    @State private var percet = 0.0
    @State private var waveOffset = Angle(degrees: 0)
    @State private var waveOffset2 = Angle(degrees: 180)

    // Свойства для пикера
    var ml = [100, 150, 200, 250, 300]
    @State private var selectedML = 200

    // Свойства для дневной нормы
    @AppStorage("dailyRate")  var dailyRate = 1800
    @State private var date = Date()

    // Инициализация цветов для пикера
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
                // Отображение общего потребления воды за день
                if let existingIndex = dailyWaterConsumption.firstIndex(where: { $0.date.formatted(date: .complete, time: .omitted) == date.formatted(date: .complete, time: .omitted) }) {
                    Text("\(dailyWaterConsumption[existingIndex].totalWaterConsumed) мл.")
                        .padding(.top, 20.0)
                        .foregroundStyle(Color.cyan)
                        .font(.title)
                        .onAppear(perform: {
                            updatePercentage()
                        })
                } else {
                    Text("\(0) мл.")
                        .padding(.top, 20.0)
                        .foregroundStyle(Color.cyan)
                        .font(.title)
                }

                // Визуализация человечка и волны
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
                        animateWaves()
                    }
                    .mask {
                        if !pol.isEmpty {
                            Image(pol[0].pol ? "man" : "woman")
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

                Spacer().frame(height: 5)

                // Пикер выбора порции
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

                    // Кнопка добавления воды
                    HStack {
                        Image(systemName: "plus")
                            .foregroundStyle(.cyan)

                        Button {
                            addWater()
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

                Spacer().frame(height: 15)

                // Настройка дневной нормы
                VStack(spacing: 5.0) {
                    Text("Выбери свою дневную норму")
                        .foregroundStyle(.cyan)
                        .font(.system(size: 18))
                    HStack {
                        // Кнопки уменьшения и увеличения дневной нормы
                        Button {
                            updateDailyRate(-100)
                        } label: {
                            Image(systemName: "minus.circle")
                                .foregroundStyle(.cyan)
                                .font(.system(size: 30))
                        }

                        Text("\(dailyRateSave.first?.dailyRate ?? 1800)")
                            .onChange(of: dailyRateSave.first?.dailyRate) { _ in
                                updatePercentage()
                            }
                            .foregroundStyle(.cyan)
                            .font(.system(size: 28))

                        Button {
                            updateDailyRate(100)
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

    // Обновление процента
    private func updatePercentage() {
        if let existingIndex = dailyWaterConsumption.firstIndex(where: { $0.date.formatted(date: .complete, time: .omitted) == date.formatted(date: .complete, time: .omitted) }) {
            let daily: Double = Double(self.dailyRate)
            let total: Double = Double(dailyWaterConsumption[existingIndex].totalWaterConsumed)
            let chislo: Double = Double(daily / total)
            let procent: Double = Double(100 / chislo)
            percet = procent
        } else {
            percet = 0
        }
    }

    // Добавление воды
    private func addWater() {
        let date = Date()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let timeString = timeFormatter.string(from: date)

        if let existingIndex = dailyWaterConsumption.firstIndex(where: { $0.date.formatted(date: .complete, time: .omitted) == date.formatted(date: .complete, time: .omitted) }) {
            dailyWaterConsumption[existingIndex].totalWaterConsumed += selectedML
            updatePercentage()
        } else {
            let newConsumption = DailyWaterConsumption(totalWaterConsumed: selectedML, date: date)
            context.insert(newConsumption)
            percet = 100 // Adjust if needed
        }

        if let index = waterConsumptionByDate.firstIndex(where: { $0.date.formatted(date: .complete, time: .omitted) == date.formatted(date: .complete, time: .omitted) }) {
            waterConsumptionByDate[index].porcaica.append(selectedML)
            waterConsumptionByDate[index].vremia.append(timeString)
        } else {
            let consumption = WaterConsumptionByDate(date: date, vremia: [timeString], porcaica: [selectedML])
            context.insert(consumption)
        }
    }
    
    // Обновление дневной нормы
        private func updateDailyRate(_ value: Int) {
            if self.dailyRate > 0 {
                self.dailyRate += value
                if dailyRateSave.isEmpty {
                    let chislo = DailyRate(dailyRate: self.dailyRate)
                    context.insert(chislo)
                } else {
                    dailyRateSave[0].dailyRate = self.dailyRate
                }
                updatePercentage()
            }
        }


    // Анимация волн
    private func animateWaves() {
        withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
            self.waveOffset = Angle(degrees: 360)
            self.waveOffset2 = Angle(degrees: -180)
        }
    }
}
   #Preview {
       AddWater()
           
   }
