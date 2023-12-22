//
//  Grafic.swift
//  Drink Water
//
//  Created by Anton Rasen on 15.12.2023.
//

import SwiftUI
import Charts
import SwiftData


struct Grafic: View {
    
    
    @Environment(\.modelContext) var context
  
    @Query var dailyWaterConsumption: [DailyWaterConsumption]
    
    var body: some View {
      

            VStack {
              
                    GroupBox ( "Bar Chart - Step Count") {
                                Chart(dailyWaterConsumption) {
                                    let totalWaterConsumed1 = $0.totalWaterConsumed
                                    BarMark(
                                        x: .value("Week Day", $0.date, unit: .day),
                                        y: .value("Step Count", $0.totalWaterConsumed)
                                            
                                    )
                                    
                                    .foregroundStyle(Color.cyan)
                                    .annotation(position: .top, alignment: .center, spacing: 5) {
                                                                    Text("\(totalWaterConsumed1)")
                                                                        .font(.footnote)
                                                                        .foregroundColor(.cyan)
                                                                        .fontWeight(.bold)
                                     }
                                }
                               .chartScrollableAxes(.horizontal)
//                               .chartYAxis {
//                                    AxisMarks(position: .leading)
//                                     
//                                }
                        
                                .chartXAxis {
                                    AxisMarks (values: .stride (by: .day)) { value in
                                        AxisGridLine().foregroundStyle(.cyan)
                                        
                                        AxisValueLabel(format: .dateTime.day(),
                                                       centered: true)
                                    }
                                }
                            }
                    .frame(height: 350)
                
                        
                        Spacer()
                    }
                    .padding()
            
         
        
        
       
        }
}

#Preview {
    Grafic()
        .environmentObject(HistoryClass())
}

