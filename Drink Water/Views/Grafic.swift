//
//  Grafic.swift
//  Drink Water
//
//  Created by Anton Rasen on 15.12.2023.
//

import SwiftUI
import Charts

struct Grafic: View {
    @EnvironmentObject var history: HistoryClass
    
    var body: some View {
        ScrollView {
            VStack {
                    GroupBox ( "История") {
                        Chart(history.dailyConsumptions) {
                            let totalWaterConsumed = $0.totalWaterConsumed
                            BarMark(
                                x: .value("Step Count", $0.totalWaterConsumed),
                                y: .value("Week Day", $0.date, unit: .day)
                            )
                            .foregroundStyle(Color.cyan)
                            .annotation(position: .overlay, alignment: .trailing, spacing: 5) {
                                Text("\(totalWaterConsumed) мл")
                                    .font(.footnote)
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                            }
                        }
                        .chartXAxis(.hidden)
                        .chartYAxis {
                            AxisMarks (position: .leading, values: .stride (by: .day)) { value in
                                AxisValueLabel(format: .dateTime.day(),
                                               centered: true)
                            }
                        }
                    }
                    .frame(height: 500)
                    
                    Spacer()
                       
                }
            .padding()
            
            VStack {
                        GroupBox ( "Bar Chart - Step Count") {
                            Chart(history.dailyConsumptions) {
                                BarMark(
                                    x: .value("Week Day", $0.date, unit: .day),
                                    y: .value("Step Count", $0.totalWaterConsumed)
                                )
                            }
                        }
                        .frame(height: 500)
                        
                        Spacer()
                    }
                    .padding()
        }
        
       
        }
}

#Preview {
    Grafic()
        .environmentObject(HistoryClass())
}

struct DailyWaterConsumption: Identifiable, Hashable {
    let id = UUID()
    let date: Date
    var totalWaterConsumed: Int
}

struct StepCount: Identifiable, Hashable, Comparable {
    static func < (lhs: StepCount, rhs: StepCount) -> Bool {
        return lhs.weekday < rhs.weekday
    }
    let id = UUID()
    let weekday: Date
    let steps: Int
    
    
    init(day: String, steps: Int) {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "yyyyLLdd"
        
        
        self.weekday = formatter.date(from: day) ?? Date.distantPast
        self.steps = steps
    }
    
    var weekdayString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "yyyyLLdd"
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        return  dateFormatter.string(from: weekday)
    }
}
