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
        VStack {
            AddWater()
        }
        .task {
            try? await lnManager.requestAuthorization()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(LocalNotificationManager())
}
