import SwiftUI

@main
struct HealthyRingerApp: App {
//    init() {
//        UITabBar.appearance().barTintColor = UIColor(Color("BackgroundColorSet"))
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithOpaqueBackground()
//        appearance.backgroundColor = UIColor(Color("BackgroundColorSet"))
//        
//        UINavigationBar.appearance().standardAppearance = appearance
//        UINavigationBar.appearance().scrollEdgeAppearance = appearance
//    }
    
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
            .preferredColorScheme(.dark) // Добавьте этот модификатор для темной темы
        }
    }
}
