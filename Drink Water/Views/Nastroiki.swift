//
//  Nastroiki.swift
//  Drink Water
//
//  Created by Anton Rasen on 03.01.2024.
//

import SwiftUI
import SwiftData

struct Nastroiki: View {
    @Environment(\.modelContext) var context
    @Query var pol: [Pol]
    
    @State private var date = Date()
    
   
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            VStack {
                VStack {
                    
                    Text("Выбери пол: ")
                        .foregroundStyle(.cyan)
                        .font(.system(size: 25))
                        .padding(.bottom, 3)
                    HStack {
                        
                        Button{
                            if pol.isEmpty {
                                let newPol = Pol(pol: true)
                                context.insert(newPol)
                            } else {
                                pol[0].pol = true
                            }
                           
                        } label: {
                            VStack {
                                Text("Мужской")
                                    .foregroundStyle(.cyan)
                                    .font(.system(size: 20))
                                if !pol.isEmpty {
                                    Image(pol[0].pol ? "manCyanGal" : "manCyanl")
                                        .resizable()
                                        .frame(width: 110, height: 170)
                                        .aspectRatio(contentMode: .fill)
                                } else {
                                   Image("manCyan")
                                        .resizable()
                                        .frame(width: 110, height: 170)
                                        .aspectRatio(contentMode: .fill)
                                }
                                
                            }
                        }
                        
                        Button{
                            if pol.isEmpty {
                                let newPol = Pol(pol: false)
                                context.insert(newPol)
                            } else {
                                pol[0].pol = false
                            }
                        } label: {
                            VStack {
                                Text("Женский")
                                    .foregroundStyle(.cyan)
                                    .font(.system(size: 20))
                                if !pol.isEmpty {
                                    Image(pol[0].pol ? "womanCyan" : "womanCyanGal")
                                        .resizable()
                                        .frame(width: 110, height: 170)
                                        .aspectRatio(contentMode: .fill)
                                } else {
                                   Image("womanCyan")
                                        .resizable()
                                        .frame(width: 110, height: 170)
                                        .aspectRatio(contentMode: .fill)
                                }
                               
                            }
                        }
                    }
                    
                    
                }
                                .frame(width: 320.0, height: 280)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.cyan, lineWidth: 2)
            )
                .padding(.top, 40.0)

                Spacer()
                
                
                
            }
            
        }
    }
}

#Preview {
    Nastroiki()
    
}
