//
//  Nastroiki.swift
//  Drink Water
//
//  Created by Anton Rasen on 03.01.2024.
//

import SwiftUI
import SwiftData
import AVFoundation

struct Nastroiki: View {
    @Environment(\.modelContext) var context
    @EnvironmentObject var lnManager: LocalNotificationManager
    
     @Query var pol: [Pol]
    
    
    
    @State var audioPlayer: AVAudioPlayer!
    
    @AppStorage("selectedSound") var selectedSound: String = "signal.wav"
    
    @State private var date = Date()
    
    @AppStorage("galochka") var galochka = 1
    
   
    
    func playSounds(_ soundFileName : String) {
        // Проверяем, воспроизводится ли звук в данный момент
        if audioPlayer != nil && audioPlayer.isPlaying {
            // Если да, останавливаем его
            audioPlayer.stop()
        }

        guard let soundURL = Bundle.main.url(forResource: soundFileName, withExtension: nil) else {
            fatalError("Unable to find \(soundFileName) in bundle")
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            // Настраиваем аудиоплеер
            audioPlayer.prepareToPlay()
            // Воспроизводим звук
            audioPlayer.play()
        } catch {
            print(error.localizedDescription)
        }
    }
    
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
                            if audioPlayer != nil && audioPlayer.isPlaying {
                                audioPlayer.stop()
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
                                   Image("manCyanl")
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
                            if audioPlayer != nil && audioPlayer.isPlaying {
                                audioPlayer.stop()
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
                                .frame(width: 300.0, height: 280)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.cyan, lineWidth: 2)
            )
                .padding(.top, 40.0)

           
                
                VStack {
                    Text("Выбор мелодии:")
                        .padding(5.0)
                        .foregroundStyle(.cyan)
                        .font(.system(size: 23))
                    
                    Divider()
                        .background(.cyan)
                    
                    VStack (alignment: .leading) {
                    
                    Button {
                        galochka = 1
                        selectedSound = "signal.wav"
                        playSounds("signal.wav")
                        // Обновите мелодию в ожидающих запросах
                        Task {
                                        await lnManager.updateNotificationSound(newSound: selectedSound)
                                    }
                    } label: {
                        HStack {
                            Text("Птици и ручей")
                                .foregroundStyle(.cyan)
                                .font(.system(size: 20))
                            Image( systemName: galochka == 1 ? "checkmark.circle" : "circle" )
                                .foregroundStyle(.cyan)
                                .font(.system(size: 18))
                        }
                    }
                     
                    
                    Divider()
                        .background(.cyan)
                    
                    Button {
                        galochka = 2
                        playSounds("More.wav")
                        selectedSound = "More.wav"
                        Task {
                                        await lnManager.updateNotificationSound(newSound: selectedSound)
                                    }
                    } label: {
                        HStack {
                            Text("Море и чайки")
                                .foregroundStyle(.cyan)
                                .font(.system(size: 20))
                            Image( systemName: galochka == 2 ? "checkmark.circle" : "circle" )
                                .foregroundStyle(.cyan)
                                .font(.system(size: 18))
                        }
                    }
                    
                        
                    Divider()
                        .background(.cyan)
                    
                    Button {
                        galochka = 3
                        playSounds("DojdiUCamina.wav")
                        selectedSound = "DojdiUCamina.wav"
                        Task {
                                        await lnManager.updateNotificationSound(newSound: selectedSound)
                                    }
                    } label: {
                        HStack {
                            Text("Дождь у камина")
                                .foregroundStyle(.cyan)
                                .font(.system(size: 20))
                            Image( systemName: galochka == 3 ? "checkmark.circle" : "circle" )
                                .foregroundStyle(.cyan)
                                .font(.system(size: 18))
                        }
                        
                    }
                        
                        Divider()
                            .background(.cyan)
                        
                        Button {
                            galochka = 4
                            playSounds("ShumVodopadaPtici.wav")
                            selectedSound = "ShumVodopadaPtici.wav"
                            Task {
                                            await lnManager.updateNotificationSound(newSound: selectedSound)
                                        }
                        } label: {
                            HStack {
                                Text("Шум водопада")
                                    .foregroundStyle(.cyan)
                                    .font(.system(size: 20))
                                Image( systemName: galochka == 4 ? "checkmark.circle" : "circle" )
                                    .foregroundStyle(.cyan)
                                    .font(.system(size: 18))
                            }
                            
                        }
                    
                    Divider()
                        .background(.cyan)
                    
                    Button {
                        galochka = 5
                        playSounds("TriKapli.wav")
                        selectedSound = "TriKapli.wav"
                        Task {
                                        await lnManager.updateNotificationSound(newSound: selectedSound)
                                    }
                    } label: {
                        HStack {
                            Text("Три капли")
                                .foregroundStyle(.cyan)
                                .font(.system(size: 20))
                            Image( systemName: galochka == 5 ? "checkmark.circle" : "circle" )
                                .foregroundStyle(.cyan)
                                .font(.system(size: 18))
                        }
                        
                    }
                        
                      
                    
                    Divider()
                        .background(.cyan)
                    
                    Button {
                        galochka = 6
                        selectedSound = ""
                        Task {
                                        await lnManager.updateNotificationSound(newSound: selectedSound)
                                    }
                        if audioPlayer != nil && audioPlayer.isPlaying {
                            audioPlayer.stop()
                        }
                    } label: {
                        HStack {
                            Text("Без звука")
                                .foregroundStyle(.cyan)
                                .font(.system(size: 20))
                            Image( systemName: galochka == 6 ? "checkmark.circle" : "circle" )
                                .foregroundStyle(.cyan)
                                .font(.system(size: 18))
                        }
                        
                    }
                }
                    .padding(.leading, 20.0)
                }
                

                .frame(width: 300.0, height: 340)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.cyan, lineWidth: 2)
                )
                .padding(.top, 20.0)
                Spacer()
            }
            
        }
        .onDisappear {
            // Остановить воспроизведение звука при переходе на другой экран
            if audioPlayer != nil && audioPlayer.isPlaying {
                audioPlayer.stop()
            }
        }
    }
}

#Preview {
    Nastroiki()
        .environmentObject(LocalNotificationManager())
}
