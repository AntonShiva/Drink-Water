//
//  NotificationHandler.swift
//  Drink Water
//
//  Created by Anton Rasen on 21.11.2023.
//

import Foundation
import UserNotifications
import AVFoundation

class NotificationHandler {
    func askPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("Access granted!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func sendNotification(date: Date, type: String, identifier: String,  title: String, body: String) {
        var trigger: UNNotificationTrigger?
        
        // Create a trigger (either from date or time based)
        if type == "date" {
            let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: date)
            trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        } 
        
        // Customise the content
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        //Play custom sound
        content.sound = UNNotificationSound(named: UNNotificationSoundName("signal.wav"))
      
       
        // Create the request
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}
