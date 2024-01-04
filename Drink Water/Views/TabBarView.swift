//
//  TabBarView.swift
//  Drink Water
//
//  Created by Anton Rasen on 12.12.2023.
//


import SwiftUI

 struct TabBarView: View {
     @EnvironmentObject var lnManager: LocalNotificationManager
     @Environment(\.scenePhase) var scenePhase
     
    @State var selectedTab: Tab = .home
    @Namespace var namespace
    
    
    
     var body: some View {
//         ZStack {
//             Color.bgTabBar
//                 .ignoresSafeArea()
         VStack {
             
                 VStack {
                     
                     TabView(selection: $selectedTab) {
                         
                         AddWater()
                             .tag(Tab.home)
                         
                         Reminders()
                             .tag(Tab.reminders)
                         
                         
                         History()
                             .tag(Tab.history)
                         
                         Nastroiki()
                             .tag(Tab.nastroiki)
                     }
                     
                     
                 }
                 
                 
                 
                 VStack {
                     ZStack {
                         Color.bgTabBar
                             .ignoresSafeArea()
                         HStack(spacing: 15) {
                             ForEach(Tab.allCases) { tab in
                                 TabButton(tab: tab, selectedTab: $selectedTab,  namespace: namespace)
                             }
                         }
                         //                         .padding()
                         .background(
                            Capsule()
                                .fill(Color.bgTabBar)
                                .frame(height: 65)
                                .frame(width: 340)
                         )
                         .frame(height: 50)
                         .shadow( radius: 9)
                     }
                     
                 }
                
//                                  .padding(.top, 20.0)
                 .frame(height: 75)
                 
             
             

         }
         .background(Color.bgTabBar)
    }
    
    private struct TabButton: View {
        let tab: Tab
        @Binding var selectedTab: Tab
       
     
       
       
        var namespace: Namespace.ID
        @State private var selectedOffset: CGFloat = 0
        @State private var rotationAngle: CGFloat = 0
        
        var body: some View {
          
            
            Button {
                withAnimation(.easeInOut) {
                    selectedTab = tab
                   
                }
                
                selectedOffset = -55
                if tab < selectedTab {
                    rotationAngle += 360
                } else {
                    rotationAngle -= 360
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    selectedOffset = 0
                    if tab < selectedTab {
                        rotationAngle += 720
                    } else {
                        rotationAngle -= 720
                    }
                }
            } label: {
                ZStack {
                    if isSelected {
                        Capsule()
                            .fill(Color.bgTabBarDark.opacity(0.8))
                            .frame(width: 80)
                            .matchedGeometryEffect(id: "Selected Tab", in: namespace)
                    }
                    HStack(spacing: 20) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 30, weight: .semibold, design: .rounded))
                            .foregroundColor(isSelected ? .bgTabBar : .blyL)
                            .rotationEffect(.degrees(rotationAngle))
                            .scaleEffect(isSelected ? 1 : 0.9)
                            .animation(.easeInOut, value: rotationAngle)
                            .opacity(isSelected ? 1 : 0.9)
                            .padding(.leading, isSelected ? 20 : 0)
                            .padding(.horizontal, selectedTab != tab ? 10 : 0)
                            .offset(y: selectedOffset)
                            .animation(.default, value: selectedOffset)
                        
                        if isSelected {
                            Text(tab.title)
                                .font(.system(size: 20, weight: .semibold, design: .rounded))
                                .foregroundColor(tab.color)
                                .padding(.trailing, 1)
                        }
                    }
                    .padding(.vertical, 10)
                }
            }
            .buttonStyle(.plain)
            
        }
        
        private var isSelected: Bool {
            selectedTab == tab
        }
        
    }
}
#Preview {
    TabBarView()
        .environmentObject(LocalNotificationManager())
}




