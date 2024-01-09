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



    // Функция для создания кнопок выбора пола
    private func genderButton(title: String, imageName: String, isMale: Bool) -> some View {
        Button {
            if pol.isEmpty {
                let newPol = Pol(pol: isMale)
                context.insert(newPol)
            } else {
                pol[0].pol = isMale
            }
            stopAudioPlayer()
        } label: {
            VStack {
                Text(title)
                    .foregroundStyle(.cyan)
                    .font(.system(size: 20))
                
                
                    if pol.isEmpty {
                        Image(imageName)
                            .resizable()
                            .frame(width: 110, height: 170)
                            .aspectRatio(contentMode: .fill)
                      
                    } else {
                        if isMale {
                            Image(  pol[0].pol ? imageName + "Gal" : imageName)
                                .resizable()
                                .frame(width: 110, height: 170)
                                .aspectRatio(contentMode: .fill)
                        } else  {
                            Image( !pol[0].pol ? imageName + "Gal" : imageName )
                                .resizable()
                                .frame(width: 110, height: 170)
                                .aspectRatio(contentMode: .fill)
                        
                    }
                }
            }
        }
    }


    // Функция для создания кнопок выбора мелодии
    func soundButton(title: String, soundFileName: String) -> some View {
        Button {
            galochka = galochka == 6 ? galochka : galochka + 1
            selectedSound = soundFileName
            stopAudioPlayer()
            Task {
                await updateNotificationSound()
                playSelectedSound()
            }
        } label: {
            HStack {
                Text(title)
                    .foregroundStyle(.cyan)
                    .font(.system(size: 20))
                Image(systemName: galochka == (galochka == 6 ? 1 : galochka) && selectedSound == soundFileName ? "checkmark.circle" : "circle")
                    .foregroundStyle(.cyan)
                    .font(.system(size: 18))
            }
        }
    }
    
    //Функция для создания мелодии по умолчанию
    func defaultSoundButton() -> some View {
        Button {
            galochka = 1
            selectedSound = "signal.wav"
            stopAudioPlayer()
            Task {
                await updateNotificationSound()
                playSelectedSound()
            }
        } label: {
            HStack {
                Text("Птици и ручей")
                    .foregroundStyle(.cyan)
                    .font(.system(size: 20))
                Image(systemName: galochka == 1 && selectedSound == "signal.wav" ? "checkmark.circle" : "circle")
                    .foregroundStyle(.cyan)
                    .font(.system(size: 18))
            }
        }
    }
    
    // Функция для воспроизведения выбранной мелодии
    func playSelectedSound() {
        guard !selectedSound.isEmpty else { return }
        
        guard let soundURL = Bundle.main.url(forResource: selectedSound, withExtension: nil) else {
            fatalError("Unable to find \(selectedSound) in bundle")
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // Функция для обновления мелодии в ожидающих запросах
    func updateNotificationSound() async {
        await lnManager.updateNotificationSound(newSound: selectedSound)
    }
    // Функция для остановки воспроизведения звука
    func stopAudioPlayer() {
        if audioPlayer != nil && audioPlayer.isPlaying {
            audioPlayer.stop()
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
                        genderButton(title: "Мужской", imageName: "manCyan", isMale: true)
                        genderButton(title: "Женский", imageName: "womanCyan", isMale: false)
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

                    Divider().background(.cyan)

                    VStack(alignment: .leading) {
                        defaultSoundButton()
                        Divider().background(.cyan)
                        soundButton(title: "Море и чайки", soundFileName: "More.wav")
                        Divider().background(.cyan)
                        soundButton(title: "Дождь у камина", soundFileName: "DojdiUCamina.wav")
                        Divider().background(.cyan)
                        soundButton(title: "Шум водопада", soundFileName: "ShumVodopadaPtici.wav")
                        Divider().background(.cyan)
                        soundButton(title: "Три капли", soundFileName: "TriKapli.wav")
                        Divider().background(.cyan)
                        soundButton(title: "Без звука", soundFileName: "")
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
            stopAudioPlayer()
        }
    }
}

#Preview {
    Nastroiki()
        .environmentObject(LocalNotificationManager())
}
