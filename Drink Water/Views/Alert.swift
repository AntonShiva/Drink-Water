//
//  Alert.swift
//  Drink Water
//
//  Created by Anton Rasen on 22.11.2023.
//

import SwiftUI

struct Alert: View {
    @State private var showFancy = false
    @State var selectedDate = Date()
    
    var body: some View {
        Button {
            showFancy = true
        } label: {
            Text("Fancy")
        }
        .customAlert(isPresented: $showFancy) {
            VStack(spacing: 20) {
                Image("jane")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .background(.ultraThinMaterial.blendMode(.multiply))
                    .clipShape(Circle())
                
                VStack(spacing: 4) {
                    Text("Remind Jane")
                        .font(.headline)
                    
                    Text("Send a reminder to Jane about \"Birthday Party\"")
                        .font(.footnote)
                }
                DatePicker("", selection: $selectedDate, displayedComponents: .hourAndMinute)
                    
                    .background(LinearGradient(gradient: Gradient(colors: [Color.cyan, Color.blue]), startPoint: .top, endPoint: .bottomTrailing))
                    .colorScheme(.light)
                    .accentColor(.white)
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .cornerRadius(300)
                    .frame(width: 250.0, height: 150)
                 
                
                    .padding()
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(Color.cyan, lineWidth: 2)
                    )
                
                
            }
            .background(Color.cyan)
        } actions: {
            
                Button(role: .cancel) {
                
                } label: {
                    Text("Cancel")
                }
                .background(Color.cyan)
                
                Button {
                   
                } label: {
                    Text("Send")
                }
                
            
            .background(Color.cyan)
        }
    }
}

#Preview {
    Alert()
}
