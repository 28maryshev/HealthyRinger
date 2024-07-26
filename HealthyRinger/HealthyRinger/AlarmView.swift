import SwiftUI

class AlarmViewModel: ObservableObject {
    @Published var isAlarmOn: Bool = true
    @Published var selectedDays: [String] = ["SUN", "MON", "TUE"]
    @Published var alarmName: String = "Alarm 1"
    @Published var alarmTime: Date = Date()
}

//MARK: - Time Widget
struct AlarmView: View {
    @ObservedObject var alarmViewModel: AlarmViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading) {
                Text(alarmViewModel.alarmName)
                    .font(.caption)
                    .foregroundColor(.gray)
                HStack {
                    Text(alarmViewModel.alarmTime, style: .time)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                    Toggle("", isOn: $alarmViewModel.isAlarmOn)
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

struct AlarmSettingsView: View {
    @ObservedObject var alarmViewModel: AlarmViewModel
    
    var body: some View {
        ZStack {
            Color("BackgroundColorSet").ignoresSafeArea()
            
            VStack {
                //MARK: - Alarm title
                HStack {
                    TextField("Enter alarm name", text: $alarmViewModel.alarmName)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color("StringColorSet"))
                    
                    Button(action: {
                        alarmViewModel.alarmName = ""
                    }) {
                        Text("Change title")
                    }
                    .padding()
                    .font(.system(size: 18, weight: .light))
                    .foregroundColor(Color("StringColorSet"))
                }
                .padding()
                
                //MARK: - Time setup
                DatePicker(
                    "",
                    selection: $alarmViewModel.alarmTime,
                    displayedComponents: .hourAndMinute
                )
                .padding()
                .labelsHidden()
                .datePickerStyle(.wheel)
                .colorInvert()
                .foregroundColor(Color("StringColorSet"))
            }
        }
    }
}

#Preview {
    AlarmSettingsView(alarmViewModel: AlarmViewModel())
}
