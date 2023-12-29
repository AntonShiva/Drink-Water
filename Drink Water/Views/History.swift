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
    
    @State private var showFullScreenCover = false
    
    var body: some View {
        NavigationStack {
            VStack {
                
                //            Grafic()
                
                DatePicker(
                    "Start Date",
                    selection: $date,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)
                
                Button("Исторя График") {
                                   showFullScreenCover.toggle()
                                   
                               }
                               .fullScreenCover(isPresented: $showFullScreenCover) {
                                   Grafic()
                               }
                
                List {
                    ForEach(waterConsumptionByDate.sorted(by: { $0.date < $1.date })) { item in
                        if item.date.formatted(date: .complete, time: .omitted) == date.formatted(date: .complete, time: .omitted) {
                            Section(header: Text(item.date.formatted(date: .long, time: .omitted))) {
                                ForEach(item.vremia.indices, id: \.self) { index in
                                    HStack {
                                        Image("glass1")
                                            .resizable()
                                            .frame(width: 40, height: 40)
                                        Text("\(item.porcaica[index])")
                                        Spacer()
                                        Text(item.vremia[index])
                                            .padding(.trailing, 50.0)
                                    }
                                    .padding(.horizontal, 50)
                                }
                            }
                        }
                        
                    }
                }
                
                
            }
            
        }
    }
}

#Preview {
    History()
       
}
