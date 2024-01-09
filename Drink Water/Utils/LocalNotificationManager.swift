//
//  LocalNotificationManager.swift
//  Drink Water
//
//  Created by Anton Rasen on 29.11.2023.
//

import Foundation
import NotificationCenter

@MainActor
class LocalNotificationManager: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    
    // текущий центр уведомлений
    let notificationCenter = UNUserNotificationCenter.current()

    // показывает статус авторизации
    @Published var isGranted = false
    // массив ожидающих запросов
    @Published var pendingRequests: [UNNotificationRequest] = []
    
    // делегат
    override init() {
        super.init()
        notificationCenter.delegate = self
    }
    
    // функция для делегата
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        await getPendingRequests()
        return [.sound, .banner]
    }
    
    // Метод для обновления мелодии в массиве pendingRequests
    func updateNotificationSound(newSound: String) async {
            for request in pendingRequests {
                // Новое содержимое уведомления с обновленной мелодией
                let newContent = UNMutableNotificationContent()
                newContent.title = request.content.title
                newContent.body = request.content.body
                newContent.subtitle = request.content.subtitle
                newContent.attachments = request.content.attachments
                newContent.userInfo = request.content.userInfo
                newContent.sound = UNNotificationSound(named: UNNotificationSoundName(newSound))
                
                // Режим "Без звука"
                if newSound.isEmpty {
                    newContent.sound = nil 
                }
                
                // Обновление запроса с новым содержимым
                let newRequest = UNNotificationRequest(identifier: request.identifier, content: newContent, trigger: request.trigger)
                
                // Удалить старый запрос
                notificationCenter.removePendingNotificationRequests(withIdentifiers: [request.identifier])
                
                // Добавить обновленный запрос
                try? await notificationCenter.add(newRequest)
            }
            
            // Получение обновленного массива ожидающих запросов
            await getPendingRequests()
        }
    
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
    // назначает уведомление
    func schedule(localNotification: LocalNotification, selectedSound: String) async {
        let content = UNMutableNotificationContent()
        content.title = localNotification.title
        content.body = localNotification.body
        
        // субтил
        if let subtitle = localNotification.subtitle {
            content.subtitle = subtitle
        }
        
        // картинка
        if let bundleImageName = localNotification.bundleImageName {
            if let url = Bundle.main.url(forResource: bundleImageName, withExtension: "") {
                if let attachment = try? UNNotificationAttachment(identifier: bundleImageName, url: url) {
                    content.attachments = [attachment]
                }
            }
        }
        if let userInfo = localNotification.userInfo {
            content.userInfo = userInfo
        }
        //Play custom sound
        content.sound = UNNotificationSound(named: UNNotificationSoundName(selectedSound))
        
        if selectedSound.isEmpty {
            content.sound = nil // Установите nil для звука, если выбран "Без звука"
        }
        
        if localNotification.scheduleType == .time {
        guard let timeInterval = localNotification.timeInterval else { return }
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval,
                                                        repeats: localNotification.repeats)
            let request = UNNotificationRequest(identifier: localNotification.identifier, content: content, trigger: trigger)
            try? await notificationCenter.add(request)
        } else {
            guard let dateComponents = localNotification.dateComponents else { return }
           
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: localNotification.repeats)
            let request = UNNotificationRequest(identifier: localNotification.identifier, content: content, trigger: trigger)
            try? await notificationCenter.add(request)
            
        }
        await getPendingRequests()
    }
    
    // обновление отложенных напоминаний
    func getPendingRequests() async {
        pendingRequests = await notificationCenter.pendingNotificationRequests()
        print("Pending: \(pendingRequests.count)")
    }
    
    // удаляет оповещение
    func removeRequest(withIdentifier identifier: String) {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        if let index = pendingRequests.firstIndex(where: {$0.identifier == identifier}) {
            pendingRequests.remove(at: index)
            print("Pending: \(pendingRequests.count)")
           
        }
    }
    // очистить все оповещения разом
    func clearRequests() {
        notificationCenter.removeAllPendingNotificationRequests()
        pendingRequests.removeAll()
        print("Pending: \(pendingRequests.count)")
    }
 }

