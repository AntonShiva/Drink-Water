//
//  AddWater.swift
//  Drink Water
//
//  Created by Anton Rasen on 10.11.2023.
//

import SwiftUI

struct AddWater: View {
    @State private var percet = 10.0
    @State private var waveOffset = Angle(degrees: 0)
    @State private var waveOffset2 = Angle(degrees: 180)
    
    var ml = [100, 150, 200, 250, 300]
    @State private var selectedML = 0
    @State private var waterCount = 0
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
         
            VStack {
                // Count label
               Text("\(waterCount) ml")
                    .padding()
                
                // MARK: Glass of water
                ZStack(alignment: .center) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.1))
                        .frame(width: 300, height: 300)
                    
                    Wave(offset: Angle(degrees: self.waveOffset.degrees), percent: percet / 100.0)
                        .fill(Color.cyan)
                        .frame(width: 300, height: 300)
                    
                    Wave(offset: Angle(degrees: self.waveOffset2.degrees), percent: percet / 100.0)
                        .fill(Color.cyan)
                        .opacity(0.5)
                        .frame(width: 300, height: 300)
                }
                .mask {
                    Image("glass")
                        .resizable()
                        .offset(x: -30)
                }
                //_____________________________________________
                
                Spacer()
                    .frame(height: 50)
                
                HStack {
                    Picker(selection: $selectedML, label:
                    Text("Choose ML")) {
                        ForEach(ml, id: \.self) {
                            Text("\($0) ml")
                            
                        }
                    
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Button {
                        percet += Double(selectedML) / 25
                        waterCount += selectedML
                    } label: {
                        Image("glass1")
                        
                            .resizable()
                            .frame(width: 50, height: 50)
                       
                    }

                }
            }
            .padding()
            .onAppear {
                withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                    self.waveOffset = Angle(degrees: 360)
                    self.waveOffset2 = Angle(degrees: -180)
                }
            }
        }
    }
}

#Preview {
    AddWater()
}
