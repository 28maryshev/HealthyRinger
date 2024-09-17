import SwiftUI

@main
struct HealthyRingerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
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
            .preferredColorScheme(.dark)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                print("Notification permission granted.")
            } else {
                print("Notification permission denied.")
            }
        }
        
        UNUserNotificationCenter.current().delegate = self
        return true
    }
    
    // Обработка получения уведомления в фоне
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let notification = response.notification
        let userInfo = notification.request.content.userInfo
        
        // Обработка уведомления
        print("Notification received with userInfo: \(userInfo)")
        
        completionHandler()
    }
    
    // Обработка отображения уведомления
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let options: UNNotificationPresentationOptions = [.alert, .sound]
        completionHandler(options)
    }
    
    
}
