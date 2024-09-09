import Foundation
import SwiftUI

struct AlarmView: View {
    @ObservedObject var alarmData: AlarmViewModel
    @ObservedObject var wakeUpIntervalData: WakeUpModel
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading) {
                Text(alarmData.alarmName)
                    .font(.caption)
                    .foregroundColor(.gray)
                HStack {
                    Text(wakeUpIntervalData.alarmTime, style: .time)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                    Toggle("", isOn: $alarmData.isAlarmEnabled)
                        .labelsHidden()
                }
                Text(alarmData.repeatDays.joined(separator: ", "))
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

#Preview {
    AlarmView(
        alarmData: AlarmViewModel(),
        wakeUpIntervalData: WakeUpModel()
    )
}
