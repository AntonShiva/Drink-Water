//
//  ContentView.swift
//  Drink Water
//
//  Created by Anton Rasen on 06.11.2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @EnvironmentObject var lnManager: LocalNotificationManager
    @EnvironmentObject var history: HistoryClass
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.modelContext) var context
    @Query var items: [HistoryStruct]
    var body: some View {
        ZStack {
            Color.bgTabBarDark
                .ignoresSafeArea()
        
        VStack {
          TabBarView()
        }
        .task {
            try? await lnManager.requestAuthorization()
        }
        .onChange(of: scenePhase) { newValue in
            if newValue == .active {
                Task {
                    await lnManager.getCurrentSettings()
                    await lnManager.getPendingRequests()
                }
            }
        }
    }
}
}

#Preview {
    ContentView()
        .environmentObject(LocalNotificationManager())
        .environmentObject(HistoryClass())
}
