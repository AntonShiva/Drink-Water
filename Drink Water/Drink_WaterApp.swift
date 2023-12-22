//
//  Drink_WaterApp.swift
//  Drink Water
//
//  Created by Anton Rasen on 06.11.2023.
//

import SwiftUI
import SwiftData

@main
struct Drink_WaterApp: App {
    @StateObject var lnManager = LocalNotificationManager()
    @StateObject var history = HistoryClass()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(lnManager)
                .environmentObject(history)
                .preferredColorScheme(.light)
        }
        .modelContainer(for: [HistoryStruct.self, DailyWaterConsumption.self])
    
    }
}
