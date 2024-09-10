import SwiftUI

struct HomeView: View {
    @ObservedObject var alarmViewModel: AlarmViewModel
    @ObservedObject var wakeUpIntervalData: WakeUpModel
    @ObservedObject var soundSettingsViewData: SoundSettingsViewModel
    @State private var selectedTab = 2
    
    @State private var isEditingNewAlarm = false
    @State private var editingAlarmIndex: Int? = nil
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // MARK: - Alarm Tab
            NavigationView {
                Color("BackgroundColorSet").ignoresSafeArea()
            }
            .tabItem {
                Image(systemName: "waveform")
                Text("Statistic")
            }.tag(1)
            
            NavigationView {
                VStack {
                    ScrollView {
                        ForEach(alarmViewModel.alarms.indices, id: \.self) { index in
                            NavigationLink(
                                destination: AlarmSettingsView(
                                    alarmViewModel: alarmViewModel,
                                    wakeUpIntervalData: wakeUpIntervalData,
                                    soundSettingsViewData: soundSettingsViewData,
                                    delayData: DelayViewModel(),
                                    alarmIndex: index
                                )
                                .onAppear {
                                    alarmViewModel.loadAlarm(at: index)
                                }
                            ) {
                                AlarmWidgetView(alarm: alarmViewModel.alarms[index])  // Передаем конкретный будильник
                            }
                        }
                        
                        // Кнопка добавления нового будильника
                        NavigationLink(
                            destination: AlarmSettingsView(
                                alarmViewModel: alarmViewModel,
                                wakeUpIntervalData: wakeUpIntervalData,
                                soundSettingsViewData: soundSettingsViewData,
                                delayData: DelayViewModel()
                            ),
                            isActive: $isEditingNewAlarm
                        ) {
                            Button(action: {
                                alarmViewModel.resetCurrentAlarm() // Сброс данных для нового будильника
                                isEditingNewAlarm = true
                            }) {
                                Text("+")
                                    .fontWeight(.thin)
                                    .font(.system(size: 54))
                                    .frame(width: 100, height: 46)
                                    .foregroundColor(Color("BackgroundColorSet"))
                                    .background(Color("StringColorSet"))
                                    .cornerRadius(10)
                                    .padding()
                            }
                        }
                    }.background(Color("BackgroundColorSet"))
                }
            }
            .tabItem {
                Image(systemName: "alarm")
                Text("Alarm")
            }.tag(2)
            
            // MARK: - Settings Tab
            NavigationView {
                Color("BackgroundColorSet").ignoresSafeArea()
            }
            .tabItem {
                Image(systemName: "gearshape.fill")
                Text("Settings")
            }.tag(3)
        }
    }
}

#Preview {
    HomeView(
        alarmViewModel: AlarmViewModel(),
        wakeUpIntervalData: WakeUpModel(),
        soundSettingsViewData: SoundSettingsViewModel()
    )
}
