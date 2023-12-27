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
    
    @Query var items: [HistoryStruct]
    @Query var dailyWaterConsumption: [DailyWaterConsumption]
    @Query var waterConsumptionByDate: [WaterConsumptionByDate]
    
    var body: some View {
        VStack {
            Grafic()

            List {
                ForEach(waterConsumptionByDate.sorted(by: { $0.date < $1.date })) { item in
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
            .overlay {
                if items.isEmpty {
                    Text("No Items")
                }
            }
        }
    }
}

#Preview {
    History()
       
}
