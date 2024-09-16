import Foundation
import SwiftUI

class AlarmViewModel: ObservableObject {
    @Published var alarms: [Alarm] = []

    @Published var alarmName: String = "Alarm 1"
    @Published var time = Date()
    @Published var isAlarmEnabled: Bool = false
    @Published var repeatDays: [String] = ["MON", "TUE", "WED", "THU", "FRI"]

    @Published var week: [String] = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"]

    init() {
           // Проверяем, есть ли будильники. Если нет, добавляем стандартный будильник.
           if alarms.isEmpty {
//               // Установка времени на 6:00 утра
//               var dateComponents = DateComponents()
//               dateComponents.hour = 6
//               dateComponents.minute = 0

               // Получаем текущую дату
               let currentCalendar = Calendar.current
               let currentDate = currentCalendar.startOfDay(for: Date())
               
               // Устанавливаем время на 7:00 утра текущего дня
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

       // Добавление нового будильника
       func addAlarm() {
           let newAlarm = Alarm(
               name: alarmName,
               time: time,
               isAlarmEnabled: isAlarmEnabled,
               repeatDays: repeatDays
           )
           alarms.append(newAlarm)
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
        alarmName = "New Alarm"
        time = Date()
        isAlarmEnabled = true
        repeatDays = ["MON", "TUE", "WED", "THU", "FRI"]
    }

    // Загрузка данных существующего будильника
    func loadAlarm(at index: Int) {
        if index < alarms.count {
            let alarm = alarms[index]
            alarmName = alarm.name
            time = alarm.time
            isAlarmEnabled = alarm.isAlarmEnabled
            repeatDays = alarm.repeatDays
        }
    }
}
