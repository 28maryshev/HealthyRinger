import SwiftUI

struct AlarmView: View {
    @State private var isAlarmOn: Bool = true
    @State private var alarmTime: Date = Date()
    @State private var selectedDays: [String] = ["SUN", "MON", "THU"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading) {
                Text("Work alarm")
                    .font(.caption)
                    .foregroundColor(.gray)
                HStack {
                    Text("07:00")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                    Toggle("", isOn: $isAlarmOn)
                        .labelsHidden()
                }
                Text("SUN, MON, THU")
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
    AlarmView()
}
