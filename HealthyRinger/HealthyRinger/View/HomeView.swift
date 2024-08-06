import SwiftUI

struct HomeView: View {
    @ObservedObject var alarmViewModel: AlarmViewModel
    @State private var selectedTab = 2
    
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
                        NavigationLink(destination: AlarmSettingsView(alarmViewModel: alarmViewModel, wakeUpData: WakeUpModel())) {
                            AlarmView(alarmData: alarmViewModel)
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
    HomeView(alarmViewModel: AlarmViewModel())
}
