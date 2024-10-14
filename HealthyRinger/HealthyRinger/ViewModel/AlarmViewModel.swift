import Foundation
import SwiftUI
import ActivityKit // Импортируем ActivityKit для Live Activity

class AlarmViewModel: ObservableObject {
    @Published var alarms: [Alarm] = []
    @Published var alarmName: String = "Alarm 1"
    @Published var time = Date()
    @Published var isAlarmEnabled: Bool = false
    @Published var repeatDays: [String] = ["MON", "TUE", "WED", "THU", "FRI"]
    @Published var showAlert: Bool = false  // Состояние для отображения Alert
    
    @Published var week: [String] = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"]
    
    init() {
        // Проверяем, есть ли будильники. Если нет, добавляем стандартный будильник.
        if alarms.isEmpty {
            let currentCalendar = Calendar.current
            let currentDate = currentCalendar.startOfDay(for: Date())
            let adjustedTime = currentCalendar.date(bySettingHour: 7, minute: 0, second: 0, of: currentDate) ?? Date()
            
            let defaultAlarm = Alarm(
                name: "First Alarm",
                time: adjustedTime,
                isAlarmEnabled: isAlarmEnabled,
                repeatDays: repeatDays
            )
            alarms.append(defaultAlarm)
        }
    }

    func addAlarm() {
        let newAlarm = Alarm(
            name: alarmName,
            time: time,
            isAlarmEnabled: isAlarmEnabled,
            repeatDays: repeatDays
        )
        alarms.append(newAlarm)
        
        let content = UNMutableNotificationContent()
        content.title = "Alarm"
        content.body = "It's time to wake up!"
        content.sound = .default
        content.categoryIdentifier = "ALARM_CATEGORY" // Категория для обработки действий
        
        // Установка флага content-available
        content.userInfo = ["show_alert": true] // Кастомные данные для проверки в обработчике

        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: newAlarm.time)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error adding notification: \(error.localizedDescription)")
            }
        }
    }
    
    // Обновление существующего будильника
    func updateAlarm(at index: Int) {
        if index < alarms.count {
            alarms[index] = Alarm(
                name: alarmName,
                time: time,
                isAlarmEnabled: isAlarmEnabled,
                repeatDays: repeatDays
            )
        }
    }
    
    // Удаление будильника
    func deleteAlarm(at index: Int) {
        if index < alarms.count {
            alarms.remove(at: index)
        }
    }
    
    // Сброс текущих параметров будильника для создания нового
    func resetCurrentAlarm() {
        // Сброс параметров будильника
    }
    
    // Функция для запуска Live Activity
    func startLiveActivity() {
        Task {
            let attributes = AlarmActivityAttributes(name: alarmName)
            let contentState = AlarmActivityAttributes.ContentState(progress: 0.0)
            
            do {
                // Используем await для асинхронного вызова
                let activity = try await Activity.request(attributes: attributes, contentState: contentState, pushType: nil)
                print("Live Activity started: \(activity.id)")
            } catch {
                print("Failed to start Live Activity: \(error.localizedDescription)")
            }
        }
    }
    
    // Функция для остановки Live Activity
    func stopLiveActivity() {
        Task {
            guard let activity = Activity<AlarmActivityAttributes>.activities.first else { return }
            // Используем await для завершения активности
            await activity.end(dismissalPolicy: .immediate)
        }
    }
}
