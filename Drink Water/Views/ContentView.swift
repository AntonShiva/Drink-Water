//
//  ContentView.swift
//  Drink Water
//
//  Created by Anton Rasen on 06.11.2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var lnManager: LocalNotificationManager
    @Environment(\.scenePhase) var scenePhase
    var body: some View {
        ZStack {
            Color.bgTabBarDark
                .ignoresSafeArea()
        
        VStack {
            AddWater()
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
        
}
