import SwiftUI

class AlarmViewModel: ObservableObject {

    @Published var selectedDays: [String] = []
    @Published var alarmName: String = "Alarm 1"
    @Published var alarmTime = Date()
    
    @Published var soundValue: String = "Light tone (default)"
    @Published var week: [String] = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"]
}


//MARK: - START VIEW
struct AlarmSettingsView: View {
    @ObservedObject var alarmViewModel: AlarmViewModel
    @ObservedObject var wakeUpData: WakeUpModel
    
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
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
                    
                    //MARK: - ????????????????????/
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
                    
                    //MARK: - Wake-up interval
                    HStack {
                        Text("Wake-up interval:")
                            .font(.system(size: 18, weight: .light))
                            .foregroundColor(Color("StringColorSet"))
                        Spacer()
                        
                        Picker(selection: $wakeUpData.selectedInterval, label: Text("\(wakeUpData.selectedInterval) min")) {
                            ForEach(wakeUpData.intervalOptions, id: \.self) { interval in
                                Text("\(interval) min").tag(interval)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .accentColor(Color("StringColorSet").opacity(0.5))
                        
                    }
                    .padding()
                    
                    WakeUpInterval(wakeUpIntervalData: WakeUpModel(), alarmData: AlarmViewModel())
                    
                    HStack {
                        Text("Sound:")
                            .font(.system(size: 18, weight: .light))
                            .foregroundColor(Color("StringColorSet"))
                        
                        Spacer()
                        
                        //MARK: - SoundSettingsView
                        NavigationLink(destination: SoundSettingsView()) {
                            HStack {
                                Text("\(alarmViewModel.soundValue)")
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
}

#Preview {
    AlarmSettingsView(alarmViewModel: AlarmViewModel(), wakeUpData: WakeUpModel())
}
