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
                                Text("\(histori.steps) мл")
                                Text("\(histori.weekday.description) ")
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
        .environmentObject(HistoryClass())
}
