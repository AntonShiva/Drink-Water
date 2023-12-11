//
//  DailyNorm.swift
//  Drink Water
//
//  Created by Anton Rasen on 08.12.2023.
//

import SwiftUI

struct DailyNorm: View {
    @Binding  var dailyRate: Int
    
    var body: some View {
        Text("\(self.dailyRate) мл.")
            .foregroundStyle(.cyan)
            .font(.system(size: 28))
    }
}

#Preview {
    ContentView()
}
