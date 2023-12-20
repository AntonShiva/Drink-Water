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
                ScrollView {
                    GroupBox ( "Bar Chart - Step Count") {
                                Chart(history.dailyConsumptions) {
                                    let totalWaterConsumed = $0.totalWaterConsumed
                                    BarMark(
                                        x: .value("Week Day", $0.date, unit: .day),
                                        y: .value("Step Count", $0.totalWaterConsumed)
                                            
                                    )
                                    
                                    .foregroundStyle(Color.cyan)
                                    .annotation(position: .top, alignment: .center, spacing: 5) {
                                                                    Text("\(totalWaterConsumed)")
                                                                        .font(.footnote)
                                                                        .foregroundColor(.cyan)
                                                                        .fontWeight(.bold)
                                     }
                                    
                                    RuleMark(y: .value("Average Profit", (1800)))
                                        .foregroundStyle(.gray)
                                }
                            
                                .chartScrollableAxes(.horizontal)
                                
                                .chartYAxis {
                                    AxisMarks(position: .leading)
                                        
                                }
                        
                                .chartXAxis {
                                    AxisMarks (values: .stride (by: .day)) { value in
                                        AxisGridLine().foregroundStyle(.cyan)
                                        
                                        AxisValueLabel(format: .dateTime.day(),
                                                       centered: true)
                                    }
                                }
                            }
                    .frame(height: 400)
                }
                        
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

struct DailyWaterConsumption: Identifiable, Hashable, Comparable {
    static func < (lhs: DailyWaterConsumption, rhs: DailyWaterConsumption) -> Bool {
        return lhs.date < rhs.date
    }
    
    let id = UUID()
    let date: Date
    var totalWaterConsumed: Int
    
//    init(date: Date, totalWaterConsumed: Int) {
//        let formatter = DateFormatter()
//                formatter.dateFormat = "yyyyMMdd"
//                
//                 
//        self.date = formatter.date(from: date) ?? Date.distantPast
//        print(date)
//        self.totalWaterConsumed = totalWaterConsumed
//    }
    
}

struct HistoryStruct: Identifiable, Hashable, Comparable {
    static func < (lhs: HistoryStruct, rhs: HistoryStruct) -> Bool {
        return lhs.weekday < rhs.weekday
    }
    let id = UUID()
    let weekday: String
    let porcia: Int
    let date: Date
    
    
//    init(day: String, porcia: Int) {
////        let formatter = DateFormatter()
////        formatter.locale = Locale(identifier: "ru_RU")
////        formatter.dateFormat = "yyyyLLdd HH:mm"
//        let dateFormatter = ISO8601DateFormatter()
////        dateFormatter.locale = Locale(identifier: "ru_RU_POSIX")
////        dateFormatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ssZ"
////        dateFormatter.timeZone = TimeZone.current
////        dateFormatter.locale = Locale.current
//        self.weekday = dateFormatter.date(from: day) ?? Date.distantPast
//        print(day)
//        self.porcia = porcia
//    }
    
//    var weekdayString: String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: "ru_RU")
//        dateFormatter.dateFormat = "yyyyLLdd HH:mm"
//        dateFormatter.dateStyle = .long
//        dateFormatter.timeStyle = .none
//        
//        return  dateFormatter.string(from: weekday)
//    }
}
