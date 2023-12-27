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
    @Query var count: [HistoryCount]
  
    var body: some View {
        
        if count.count >= 10     {
        VStack {
            
            GroupBox ( "Bar Chart - Step Count") {
                Chart(dailyWaterConsumption) {
                    let totalWaterConsumed1 = $0.totalWaterConsumed
                    
                    BarMark(
                        x: .value("Week Day", $0.date, unit: .day),
                        y: .value("Step Count", $0.totalWaterConsumed),
                        width: .fixed(30)                                    )
                    
                    .foregroundStyle(Color.cyan)
                    .annotation(position: .top, alignment: .center, spacing: 5) {
                        Text("\(totalWaterConsumed1)")
                            .font(.footnote)
                            .foregroundColor(.cyan)
                            .fontWeight(.bold)
                    }
                }
                .chartScrollableAxes(.horizontal)
                
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
   } else {
       VStack {
           
           GroupBox ( "Bar Chart - Step Count") {
               Chart(dailyWaterConsumption) {
                   let totalWaterConsumed1 = $0.totalWaterConsumed
                   
                   BarMark(
                       x: .value("Week Day", $0.date, unit: .day),
                       y: .value("Step Count", $0.totalWaterConsumed),
                       width: .fixed(30)                                    )
                   
                   .foregroundStyle(Color.cyan)
                   .annotation(position: .top, alignment: .center, spacing: 5) {
                       Text("\(totalWaterConsumed1)")
                           .font(.footnote)
                           .foregroundColor(.cyan)
                           .fontWeight(.bold)
                   }
               }
              
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
}

#Preview {
    Grafic()
       
}

