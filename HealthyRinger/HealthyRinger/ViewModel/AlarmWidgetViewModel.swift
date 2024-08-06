import Foundation
import SwiftUI

struct AlarmView: View {
    @ObservedObject var alarmData: AlarmViewModel
    @State var isAlarmOn: Bool = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading) {
                Text(alarmData.alarmName)
                    .font(.caption)
                    .foregroundColor(.gray)
                HStack {
                    Text(alarmData.alarmTime, style: .time)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                    Toggle("", isOn: $isAlarmOn)
                        .labelsHidden()
                }
                Text("SUN, MON, TUE")
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
    AlarmView(alarmData: AlarmViewModel())
}
