//
//  LocalNotificationManager.swift
//  Drink Water
//
//  Created by Anton Rasen on 29.11.2023.
//

import Foundation
import NotificationCenter

@MainActor
class LocalNotificationManager: ObservableObject {
    
    // текущий центр уведомлений
    let notificationCenter = UNUserNotificationCenter.current()

    
    // показывает статус авторизации
    @Published var isGranted = false
    
    // запросить авторизацию (разрешение) для отправки и отображения уведомлений
    func requestAuthorization() async throws {
        try await notificationCenter
            .requestAuthorization(options: [.sound, .badge, .alert])
        await getCurrentSettings()
    }
    
    
    // получает сведения о текущей настройке авторизации
    func getCurrentSettings() async {
        let currentSettings = await notificationCenter.notificationSettings()
        isGranted = (currentSettings.authorizationStatus == .authorized)
        print(isGranted)
    }
    
    // открывает настройки что бы в настройках телефона можно было дать разрешение на отправку сообщений
    func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                Task {
                    await UIApplication.shared.open(url)
                }
            }
        }
    }
}
