import Foundation
import SwiftUI

struct AlarmWidgetView: View {
    let alarm: Alarm  // Будильник передается как параметр
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading) {
                Text(alarm.name)  // Используем имя конкретного будильника
                    .font(.caption)
                    .foregroundColor(.gray)
                HStack {
                    Text(alarm.time, style: .time)  // Отображаем время будильника
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                    Toggle("", isOn: .constant(alarm.isAlarmEnabled))  // Статус включения/выключения
                        .labelsHidden()
                }
                Text(alarm.repeatDays.joined(separator: ", "))  // Повторяющиеся дни
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color("FramesColorSet"))
            .cornerRadius(10)
        }
        .padding()
        .edgesIgnoringSafeArea(.all)
    }
}

