import Foundation
import SwiftUI

class AlarmViewModel: ObservableObject {
    @Published var alarms: [Alarm] = []
    
    @Published var alarmName: String = "Alarm 1"
    @Published var time = Date()
    @Published var isAlarmEnabled: Bool = true
    @Published var repeatDays: [String] = ["MON", "TUE", "WED", "THU", "FRI"]
    
    @Published var week: [String] = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"]
    
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
    
    // Метод для обновления параметров будильника
    func updateAlarm(at index: Int, with alarm: Alarm) {
        if index < alarms.count {
            alarms[index] = alarm
        }
    }
}
