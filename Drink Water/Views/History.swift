//
//  History.swift
//  Drink Water
//
//  Created by Anton Rasen on 13.12.2023.
//
import SwiftUI
import SwiftData
struct History: View {

    @Environment(\.modelContext) var context
    
   
    @Query var dailyWaterConsumption: [DailyWaterConsumption]
    @Query var waterConsumptionByDate: [WaterConsumptionByDate]
    
    @State private var date = Date()
    
    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "MM LLLL yyyy"  // Формат отображения месяца и года на русском

        return dateFormatter.string(from: date)
    }
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            VStack {
                VStack {
                    RoundedRectangle(cornerRadius: 15)
                                      .fill(Color.cyan)
                                      .frame(width: 370, height: 330, alignment: .center)
                                      .overlay(
                                  DatePicker(
                                      "Start Date",
                                      selection: $date,
                                      displayedComponents: [.date]
                                          
                                  )
                                  .environment(\.locale, Locale(identifier: "ru_RU"))
                                  .frame(width: 340, height: 330, alignment: .center)
                                  .clipped()
                                  .tint(.bly)
                                  .datePickerStyle(.graphical)
                                  .background(Color.cyan)
                                  .padding(20)
                                 
                                )
                                      .padding(15)
                    
                  
                }
                
                VStack {
                    List {
                        ForEach(waterConsumptionByDate.sorted(by: { $0.date < $1.date })) { item in
                            if item.date.formatted(date: .complete, time: .omitted) == date.formatted(date: .complete, time: .omitted) {
                                Section(header: Text(formatDate(item.date))
                                                                            .font(.title)
                                                                            .foregroundColor(.cyan)
                                                                            
                                                                            .frame(maxWidth: .infinity, alignment: .center)
                                                                            .textCase(.none))
                                {
                                    ForEach(item.vremia.indices, id: \.self) { index in
                                        HStack {
                                            Image("glass1")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                                .padding(.leading, 15.0)
                                            Text("-  \(item.porcaica[index]) мл")
                                                .foregroundColor(.cyan)
                                                
                                            
                                            Spacer()
                                            
                                            Text(item.vremia[index])
                                                .foregroundColor(.cyan)
                                                .padding(.trailing, 20.0)
                                        }
                                       
                                      
                                        .frame(width: 300.0, height: 50)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.cyan, lineWidth: 2)
                                        )
                                    }
                                    .padding(.horizontal, 20)
                                    
                                }
                            }
                            
                        }
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                    }
                    .scrollContentBackground(.hidden)
                    
                    Spacer()
                }
                
               
            }
            .padding(.top, 30)
           
        }
    }
}

#Preview {
    History()
       
}
