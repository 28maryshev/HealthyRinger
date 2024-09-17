import Foundation

struct Alarm: Identifiable {
    let id = UUID()
    var name: String
    var time: Date
    var isAlarmEnabled: Bool
    var repeatDays: [String]
}
