import SwiftUI

@main
struct HealthyRingerApp: App {
    
    var body: some Scene {
        WindowGroup {
            let alarmViewModel = AlarmViewModel()
            let wakeUpIntervalData = WakeUpModel()
            let soundSettingsViewData = SoundSettingsViewModel()
                     
            HomeView(
                alarmViewModel: alarmViewModel,
                wakeUpIntervalData: wakeUpIntervalData,
                soundSettingsViewData: soundSettingsViewData
            )
        }
    }
}
