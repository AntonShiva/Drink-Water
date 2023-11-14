//
//  AddWater.swift
//  Drink Water
//
//  Created by Anton Rasen on 10.11.2023.
//

import SwiftUI

struct AddWater: View {
    // wave
    @State private var percet = 10.0
    @State private var waveOffset = Angle(degrees: 0)
    @State private var waveOffset2 = Angle(degrees: 180)
    
    // picker
    var ml = [100, 150, 200, 250, 300]
    @State private var selectedML = 0
    @State private var waterCount = 0
    
    // amount of water per day - daily rate
    @State private var dailyRate = 1800
    
    @State private var showingAlert = false
    
    
    // initializer of colors for the picker
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = #colorLiteral(red: 0.2642083466, green: 0.7893971801, blue: 1, alpha: 1)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    }
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack {
                // Count label
                Text("\(waterCount) ml")
                    .padding()
                    .foregroundStyle(Color.cyan)
                    .font(.title)
                
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
                
                VStack {
                    Text("Выбери порцию в мл.")
                        .foregroundStyle(.cyan)
                        .offset(CGSize(width: -40, height: 0))
                        .font(.title3)
                    HStack {
                        Picker("", selection: $selectedML) {
                            ForEach(ml, id: \.self) {
                                Text("\($0)")
                            }
                            
                            
                        }
                        
                        .pickerStyle(PalettePickerStyle())
                        .background(LinearGradient(gradient: Gradient(colors: [Color.cyan, Color.blue]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(7)
                        .frame(width: 200)
                        
                        Image(systemName: "plus")
                            .foregroundStyle(.cyan)
                        
                        
                        
                        Button {
                            if waterCount < dailyRate {
                                percet += Double(selectedML) / 25
                                waterCount += selectedML
                            }
                        } label: {
                            Image("glass1")
                                .resizable()
                                .frame(width: 50, height: 50)
                            
                        }
                        
                    }
                    Spacer()
                        .frame(height: 30)
                    
                    VStack {
                        HStack {
                            
                            Button {
                                if dailyRate > 0 {
                                   dailyRate -= 100
                                }
                            } label: {
                                Image(systemName: "minus.circle")
                            }
                            
                            Text("\(dailyRate)")
                            
                            Button {
                                if dailyRate < 3000 {
                                   dailyRate += 100
                                }
                            } label: {
                                Image(systemName: "plus.circle")
                            }
                        }
                        
                        Button {
                            
                            
                        } label: {
                            Text("Save")
                                .padding(20)
                                .background(.cyan)
                                .cornerRadius(20)
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
}

#Preview {
    AddWater()
}
