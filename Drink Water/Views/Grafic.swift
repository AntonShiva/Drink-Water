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
    
    @Environment(\.dismiss) var dismiss
    
    @Query var dailyWaterConsumption: [DailyWaterConsumption]
    @Query var count: [HistoryCount]
    
    @State var dateFromGrafic: Date?
    
    func updateSelectedMonth(at location: CGPoint, proxy: ChartProxy, geometry: GeometryProxy) {
          let xPosition = location.x - geometry[proxy.plotAreaFrame].origin.x
          guard let date: Date = proxy.value(atX: xPosition) else {
              return
          }
        dateFromGrafic = date
         print(date)
      }
    
    var body: some View {
        VStack {
            Button {
                dismiss()
            } label: {
                Text("Закрыть")
            }

        if count.count >= 13     {
            VStack {
                Chart(dailyWaterConsumption) {

                        let totalWaterConsumed1 = $0.totalWaterConsumed
                        
                        BarMark(
                            x: .value("Week Day", $0.date, unit: .day),
                            y: .value("Step Count", $0.totalWaterConsumed),
                            width: .fixed(30)
                        )
                        .foregroundStyle(Color.cyan)
                        .annotation(position: .top, alignment: .top, spacing: 5) {
                            Text("\(totalWaterConsumed1)")
                                
                                .font(.system(size: 10))
                                .foregroundColor(.cyan)
                                .fontWeight(.bold)
                        }
                    
                }
                .chartOverlay { proxy in
                        GeometryReader { geometry in
                            ZStack(alignment: .top) {
                                Rectangle().fill(.clear).contentShape(Rectangle())
                                    .onTapGesture { location in
                                        updateSelectedMonth(at: location, proxy: proxy, geometry: geometry)
                                    }
                            }
                        }
                    }
                .chartScrollableAxes(.horizontal)
                .chartXAxis {
                    AxisMarks (values: .stride (by: .day)) { value in
                        AxisGridLine().foregroundStyle(.cyan)
                        
                        AxisValueLabel(format: .dateTime.day().month(.defaultDigits),
                                       centered: true)
                        
                    }
                }
                
                .frame(height: 350)
                Spacer()
            }
            .padding()
            
        } else {
            VStack {
                Chart(dailyWaterConsumption) {
                    
                    let totalWaterConsumed1 = $0.totalWaterConsumed
                    
                    BarMark(
                        x: .value("Week Day", $0.date, unit: .day),
                        y: .value("Step Count", $0.totalWaterConsumed),
                        width: .fixed(30)
                    )
                    .foregroundStyle(Color.cyan)
                    .annotation(position: .top, alignment: .center, spacing: 5) {
                        Text("\(totalWaterConsumed1)")
                            .font(.footnote)
                            .foregroundColor(.cyan)
                            .fontWeight(.bold)
                    }
                    
                }
                .chartOverlay { proxy in
                    GeometryReader { geometry in
                        ZStack(alignment: .top) {
                            Rectangle().fill(.clear).contentShape(Rectangle())
                                .onTapGesture { location in
                                    updateSelectedMonth(at: location, proxy: proxy, geometry: geometry)
                                }
                        }
                    }
                }
                .chartXAxis {
                    AxisMarks (values: .stride (by: .day)) { value in
                        AxisGridLine().foregroundStyle(.cyan)
                        
                        AxisValueLabel(format: .dateTime.day(),
                                       centered: true)
                    }
                }
                
                .frame(height: 350)
                Spacer()
            }
            .padding()
        }
           
        }
      
    }
}

#Preview {
    Grafic()
    
}

