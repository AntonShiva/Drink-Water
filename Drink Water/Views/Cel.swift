//
//  Cel.swift
//  Drink Water
//
//  Created by Anton Rasen on 08.12.2023.
//

import SwiftUI

struct Cel: View {
   @Binding var waterCount: Int
    var body: some View {
        // Count label
        Text("\(self.waterCount) мл.")
            .padding(.top, 20.0)
            .foregroundStyle(Color.cyan)
            .font(.title)
    }
}

#Preview {
    ContentView()
}
