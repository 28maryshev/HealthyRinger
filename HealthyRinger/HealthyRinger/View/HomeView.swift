import SwiftUI

struct HomeView: View {
    @ObservedObject var alarmViewModel: AlarmViewModel
    @ObservedObject var wakeUpIntervalData: WakeUpModel
    @ObservedObject var soundSettingsViewData: SoundSettingsViewModel
    @State private var selectedTab = 2
    
    // Состояние для управления переходом на экран редактирования будильника
    @State private var isEditingNewAlarm = false
    
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
                ZStack {
                    Color("BackgroundColorSet").ignoresSafeArea()
                    
                    VStack {
                        // Список будильников
                        NavigationLink(
                            destination: AlarmSettingsView(
                                alarmViewModel: alarmViewModel,
                                wakeUpIntervalData: wakeUpIntervalData,
                                soundSettingsViewData: soundSettingsViewData,
                                delayData: DelayViewModel()
                            )
                        ) {
                            AlarmView(alarmData: alarmViewModel, wakeUpIntervalData: wakeUpIntervalData)
                        }

                        // NavigationLink для перехода к редактированию нового будильника
                        NavigationLink(
                            destination: AlarmSettingsView(
                                alarmViewModel: alarmViewModel,
                                wakeUpIntervalData: wakeUpIntervalData,
                                soundSettingsViewData: soundSettingsViewData,
                                delayData: DelayViewModel()
                            ),
                            isActive: $isEditingNewAlarm // Активируем переход при создании будильника
                        ) {
                            EmptyView()
                        }
                        
                        // Кнопка добавления нового будильника
                        Button(action: {
                            // Добавляем новый будильник
                            alarmViewModel.addAlarm()
                            // Активируем переход на экран редактирования
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
