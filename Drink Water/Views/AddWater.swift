//
//  AddWater.swift
//  Drink Water
//
//  Created by Anton Rasen on 10.11.2023.
//

import SwiftUI

struct AddWater: View {
    // wave
    @State private var percet = 0.0
    @State private var waveOffset = Angle(degrees: 0)
    @State private var waveOffset2 = Angle(degrees: 180)
    
    // picker
    var ml = [100, 150, 200, 250, 300]
    @State private var selectedML = 0
    @State private var waterCount = 0
    
   
    // amount of water per day - daily rate
    @State private var dailyRate = 1800
    
    
    
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
                    Image("man")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 295, height: 290)
                        
                        
                        
                }
                //_____________________________________________
                
                Spacer()
                    .frame(height: 20)
                
                VStack(alignment: .leading) {
                    Text("Выбери порцию в мл.")
                        .foregroundStyle(.cyan)
                        .font(.title3)
                    HStack {
                        Picker("Picker", selection: $selectedML) {
                            ForEach(ml, id: \.self) {
                                Text("\($0)")
                                   
                                   
                            }
                            
                            
                        }
                        
                        .pickerStyle(PalettePickerStyle())
                        .background(LinearGradient(gradient: Gradient(colors: [Color.cyan, Color.blue]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(7)
                        .frame(width: 205)
                        
                        Image(systemName: "plus")
                            .foregroundStyle(.cyan)
                        
                        
                        
                        Button {
                            if waterCount < dailyRate {
                              
                                    let chislo = dailyRate / selectedML
                                    percet += Double(100 / chislo)
                                    
                                    
                                    waterCount += selectedML
                                
                            }
                        } label: {
                            Image("glass1")
                                .resizable()
                                .frame(width: 50, height: 50)
                        }
                        }
                        
                    }
                    Spacer()
                        .frame(height: 10)
                    
                    VStack(spacing: 20.0) {
                        Text("Выбери свою дневную норму")
                            .foregroundStyle(.cyan)
                            .font(.title3)
                        HStack {
                            
                            Button {
                                if dailyRate > 0 {
                                   dailyRate -= 100
                                }
                            } label: {
                                Image(systemName: "minus.circle")
                                    .foregroundStyle(.cyan)
                                    .font(.title)
                            }
                            
                            Text("\(dailyRate) ml")
                                .foregroundStyle(.cyan)
                                .font(.title2)
                            
                            Button {
                                if dailyRate < 3000 {
                                   dailyRate += 100
                                }
                            } label: {
                                Image(systemName: "plus.circle")
                                    .foregroundStyle(.cyan)
                                    .font(.title)
                            }
                        }
                      
                    }
                    .padding(.bottom)
                    
                
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
