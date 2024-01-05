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
   
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.modelContext) var context

    
    
    var body: some View {
       
        
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

#Preview {
    ContentView()
        .environmentObject(LocalNotificationManager())
       
}
