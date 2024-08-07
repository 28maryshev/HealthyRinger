import SwiftUI

class AlarmViewModel: ObservableObject {
    @Published var selectedDays: [String] = []
    @Published var alarmName: String = "Alarm 1"
    @Published var week: [String] = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"]
}


struct AlarmSettingsView: View {
    @ObservedObject var alarmViewModel: AlarmViewModel
    @ObservedObject var wakeUpIntervalData: WakeUpModel
    @ObservedObject var soundSettingsViewData: SoundSettingsViewModel

    @State private var showingAlert = false
    
    var body: some View {
        ZStack {
            Color("BackgroundColorSet").ignoresSafeArea()
            
            VStack {
                // MARK: - Alarm title
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
                
                // MARK: - Time setup
                DatePicker(
                    "",
                    selection: $wakeUpIntervalData.alarmTime,
                    displayedComponents: .hourAndMinute
                )
                .padding()
                .labelsHidden()
                .datePickerStyle(.wheel)
                .colorInvert()
                .foregroundColor(Color("StringColorSet"))
                
                // MARK: - Choose a day
                HStack {
                    Text("Choose a day:")
                        .font(.system(size: 18, weight: .light))
                        .foregroundColor(Color("StringColorSet"))
                    Spacer()
                }
                .padding(.leading)
                
                LazyHGrid(rows: [GridItem(.flexible())], spacing: 5) {
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
                }
                .frame(height: 55)
                
                // MARK: - Wake-up interval
                HStack {
                    Text("Wake-up interval:")
                        .font(.system(size: 18, weight: .light))
                        .foregroundColor(Color("StringColorSet"))
                    Spacer()
                    
                    Picker(selection: $wakeUpIntervalData.selectedInterval, label: Text("\(wakeUpIntervalData.selectedInterval) min")) {
                        ForEach(wakeUpIntervalData.intervalOptions, id: \.self) { interval in
                            Text("\(interval) min").tag(interval)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .accentColor(Color("StringColorSet").opacity(0.5))
                    
                }
                .padding()
                
                WakeUpInterval(
                    wakeUpIntervalData: wakeUpIntervalData,
                    alarmData: alarmViewModel
                )
                
                // MARK: - SoundSettingsView
                HStack {
                    Text("Sound:")
                        .font(.system(size: 18, weight: .light))
                        .foregroundColor(Color("StringColorSet"))
                    
                    Spacer()
                    
                    NavigationLink(
                        destination: SoundSettingsView(
                            soundSettingsViewData: soundSettingsViewData
                        )
                    ) {
                        HStack {
                            Text("\(soundSettingsViewData.soundValue)") // Отображение текущего soundValue
                                .font(.system(size: 18, weight: .light))
                                .foregroundColor(Color("StringColorSet"))
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color("StringColorSet"))
                        }
                        .opacity(0.5)
                    }
                }
                .padding()
                
                Spacer()
            }
        }
    }
}

#Preview {
    AlarmSettingsView(
        alarmViewModel: AlarmViewModel(),
        wakeUpIntervalData: WakeUpModel(),
        soundSettingsViewData: SoundSettingsViewModel()
    )
}
