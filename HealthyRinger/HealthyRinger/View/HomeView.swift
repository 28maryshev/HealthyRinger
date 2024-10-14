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
            // MARK: - Statistic Tab
            NavigationView {
                Color("BackgroundColorSet").ignoresSafeArea()
            }
            .tabItem {
                Image(systemName: "waveform")
                Text("Statistic")
            }.tag(1)
            
            // MARK: - Alarm Tab
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
                                AlarmWidgetView(alarm: alarmViewModel.alarms[index])
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
                                alarmViewModel.resetCurrentAlarm()
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
                .alert(isPresented: $alarmViewModel.showAlert) { // Добавьте отображение AlarmAlertView здесь
                    Alert(
                        title: Text("Wake Up!"),
                        message: Text("It's time to wake up!"),
                        primaryButton: .default(Text("Snooze +10 min"), action: {
                            // Ваш код для отсрочки
                            Task {
                                await alarmViewModel.stopLiveActivity() // Остановить текущую Live Activity
                                await alarmViewModel.startLiveActivity() // Запустить новую Live Activity с отсрочкой
                            }
                        }),
                        secondaryButton: .destructive(Text("Stop"), action: {
                            // Ваш код для остановки будильника
                            alarmViewModel.stopLiveActivity() // Остановить текущую Live Activity
                        })
                    )
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
