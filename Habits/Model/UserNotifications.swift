//
//  UserNotifications.swift
//  Habits
//
//  Created by Alexander Thompson on 17/5/21.
//

import UIKit
import UserNotifications

class UserNotifications {
    
    ///Sends a request to the user to authosise user notifications in this app.
    func requestUserAuthorisation() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
    }
    
    // TODO: Remove static
    
    ///Removes all notifications for a habit when this is called. The 1...7 is to ensure notifications are cancelled for each day of the week.
    static func removeNotifications(title: String) {
        let center = UNUserNotificationCenter.current()
        for num in 1...7 {
            center.removePendingNotificationRequests(withIdentifiers: ["\(title)\(num)"])
        }
    }
    
    // TODO: Remove static
    ///Implements notifications for single habit using day array to confirm which days of the week the user has selected for the alarm.
    static func scheduleNotifications(alarmItem: AlarmItem) {
        let dayArray               = CoreDataMethods().convertStringArraytoBoolArray(alarmItem: alarmItem)
        let center                 = UNUserNotificationCenter.current()
        let content                = UNMutableNotificationContent()
        content.title              = alarmItem.title
        content.body               = "Time to \(alarmItem.title). You can do it!"
        content.categoryIdentifier = "alarm"
        content.sound              = UNNotificationSound.default
        
        for (index, bool) in dayArray.enumerated() {
            if bool == true {
                var dateComponents         = DateComponents()
                dateComponents.weekday     = index + 1
                dateComponents.hour        = alarmItem.hour
                dateComponents.minute      = alarmItem.minute
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                let request = UNNotificationRequest(identifier: "\(alarmItem.title)\(index)", content: content, trigger: trigger)
                center.add(request)
            }
        }
    }
    
    
    ///Checks whether user has authorised user notifications and reacts accordingly.
    func confirmRegisteredNotifications(segment: UISegmentedControl) {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { (settings) in
            
            switch settings.authorizationStatus {
            case .authorized, .provisional:
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            case .denied:
                DispatchQueue.main.async {
                    segment.selectedSegmentIndex = 0
                }
            case .notDetermined:
                self.requestUserAuthorisation()
            case .ephemeral:
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            @unknown default:
                break
            }
        }
    }
    
}



