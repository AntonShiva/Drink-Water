//
//  History.swift
//  Drink Water
//
//  Created by Anton Rasen on 13.12.2023.
//

import SwiftUI

struct History: View {
   
     @EnvironmentObject var history: HistoryClass
    
   
    
    var body: some View {
        ScrollView {
            VStack {
               Grafic()
                    Text("Истороия")
                HStack {
                    VStack {
                        ForEach(history.history.sorted(), id: \.self) { histori in
                            HStack {
                                Image("glass1")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                Text("\(histori.porcia) мл")
                                Spacer()
                                Text("\(histori.date.formatted(date: .omitted, time: .shortened)) ")
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

#Preview {
    History()
        .environmentObject(HistoryClass())
}
