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
        VStack {
           
                Text("Истороия")
            HStack {
                VStack {
                    ForEach(history.history.sorted(), id: \.self) { histori in
                        Text(histori)
                    }
                    
                }
                
                VStack{
                    ForEach(history.time.sorted(), id: \.self) { t in
                        Text(t)
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
