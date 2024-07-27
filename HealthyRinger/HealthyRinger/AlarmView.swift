import SwiftUI

class AlarmViewModel: ObservableObject {
    @Published var isAlarmOn: Bool = true
    @Published var selectedDays: [String] = []
    @Published var alarmName: String = "Alarm 1"
    @Published var alarmTime: Date = Date()
    
    @Published var week: [String] = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"]
}

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
    
    let columns: [GridItem] = [
        GridItem(.flexible())
    ]
    
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
                
                //MARK: - Choose a day
                HStack {
                    Text("Choose a day:")
                        .font(.system(size: 18, weight: .light))
                        .foregroundColor(Color("StringColorSet"))
                    Spacer()
                }
                .padding(.leading)
                
                LazyHGrid(rows: columns, spacing: 5, content: {
                    ForEach(alarmViewModel.week, id: \.self) { day in
                        Button(action: {
                            if alarmViewModel.selectedDays.contains(day) {
                                alarmViewModel.selectedDays.removeAll { $0 == day }
                            } else {
                                alarmViewModel.selectedDays.append(day)
                            }
                        }) {
                            Text(day)
                                .frame(width: 48, height: 48)
                                .background(alarmViewModel.selectedDays.contains(day) ? Color("FramesColorSet") : Color("InactiveColorSet"))
                                .foregroundColor(alarmViewModel.selectedDays.contains(day) ? Color("StringColorSet") : Color("StringColorSet").opacity(0.3))
                                .cornerRadius(50)
                        }
                    }
                })
                .frame(height: 55) // Adjust height as needed
                
                Spacer()
            }
        }
    }
}

#Preview {
    AlarmSettingsView(alarmViewModel: AlarmViewModel())
}
