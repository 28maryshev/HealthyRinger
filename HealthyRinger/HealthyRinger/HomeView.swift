//
//  HomeView.swift
//  HealthyRinger
//
//  Created by Владимир Марышев on 22.07.2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            // MARK: - Вкладка "Статистики"
            NavigationView {
                Color("BackgroundColorSet").ignoresSafeArea()
                
                
                
            }
            .tabItem {
                Image(systemName: "waveform")
                Text("Statistic")
            }
            
            // MARK: - Вкладка "Будильника"
            NavigationView {
                ZStack {
                    Color("BackgroundColorSet").ignoresSafeArea()
                    
                    NavigationLink(destination: AlarmSettingsView()) {
                        AlarmView()
                    }
                }
            }
            .tabItem {
                Image(systemName: "alarm")
                Text("Alarm")
            }
            
            // MARK: - Вкладка "Настроек"
            NavigationView {
                Color("BackgroundColorSet").ignoresSafeArea()
                
                
                
                
                
                
                
            }.tabItem {
                Image(systemName: "gearshape.fill")
                Text("Settings")
            }
        }
    }
}

#Preview {
    HomeView()
}
