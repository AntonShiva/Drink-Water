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
    var body: some View {
        VStack {
            
            Grafic()
            
            
//            List {
//                ForEach(dailyWaterConsumption.sorted(by: { $0.date < $1.date })) { item in
//                    HStack {
//                        Image("glass1")
//                            .resizable()
//                            .frame(width: 40, height: 40)
//                        Text("\(item.totalWaterConsumed)")
//                        Spacer()
//                        Text(item.date.formatted(date: .omitted, time: .shortened))
//                            .padding(.trailing, 50.0)
//                    }
//                    .padding(.horizontal, 50)
//                }
//            }
//            .overlay {
//                if items.isEmpty {
//                    Text("No Items")
//                }
//            }
            
            List {
                ForEach(items.sorted(by: { $0.date < $1.date })) { item in
                    HStack {
                        Image("glass1")
                            .resizable()
                            .frame(width: 40, height: 40)
                        Text("\(item.porcia)")
                        Spacer()
                        Text(item.date.formatted(date: .omitted, time: .shortened))
                            .padding(.trailing, 50.0)
                    }
                    .padding(.horizontal, 50)
                }
            }
            .overlay {
                if items.isEmpty {
                    Text("No Items")
                }
            }
        }
    }
    //    var body: some View {
    //        ScrollView {
    //            VStack {
    //               Grafic()
    //                    Text("Истороия")
    //                HStack {
    //                    VStack {
    //
    //
    ////                        ForEach(history.history.sorted(), id: \.self) { histori in
    ////                            HStack {
    ////                                Image("glass1")
    ////                                    .resizable()
    ////                                    .frame(width: 40, height: 40)
    ////                                Text("\(histori.porcia) мл")
    ////                                Spacer()
    ////                                Text("\(histori.date.formatted(date: .omitted, time: .shortened)) ")
    ////                                    .padding(.trailing, 50.0)
    ////                            }
    ////                            .padding(.horizontal, 50)
    ////                        }
    //
    //                    }
    //
    //
    //                }
    //            }
    //        }
    //    }
}

#Preview {
    History()
       
}
