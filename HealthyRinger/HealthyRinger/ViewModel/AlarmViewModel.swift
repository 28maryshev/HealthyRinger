import Foundation
import SwiftUI

class AlarmViewModel: ObservableObject {
    @Published var alarms: [Alarm] = []

    @Published var alarmName: String = "Alarm 1"
    @Published var time = Date()
    @Published var isAlarmEnabled: Bool = true
    @Published var repeatDays: [String] = ["MON", "TUE", "WED", "THU", "FRI"]

    @Published var week: [String] = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"]

    init() {
           // Проверяем, есть ли будильники. Если нет, добавляем стандартный будильник.
           if alarms.isEmpty {
               let defaultAlarm = Alarm(
                   name: "Default Alarm",
                   time: time,
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
