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
  
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(lnManager)
             
                .preferredColorScheme(.light)
        }
        .modelContainer(for: [HistoryStruct.self, DailyWaterConsumption.self, HistoryCount.self, WaterConsumptionByDate.self])
    
    }
}
