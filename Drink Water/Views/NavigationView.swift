//
//  NavigationView.swift
//  Drink Water
//
//  Created by Anton Rasen on 13.12.2023.
//

import SwiftUI

struct NavigationView: View {
    var body: some View {
        TabView {
            Text("Reminders")
                .tag("1")
                .tabItem {
                    Image(systemName: "bell.fill")
                }
            
            AddWater()
                .tag("2")
                .tabItem {
                    Image(systemName: "drop.fill")
                }
            
            History()
                .tag("3")
                .tabItem {
                    Image(systemName: "calendar")
                }
            
            
        }
    }
}

#Preview {
    NavigationView()
}
