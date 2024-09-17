import SwiftUI

struct AlarmSettingsView: View {
    @ObservedObject var alarmViewModel: AlarmViewModel
    @ObservedObject var wakeUpIntervalData: WakeUpModel
    @ObservedObject var soundSettingsViewData: SoundSettingsViewModel
    @ObservedObject var delayData: DelayViewModel
    
    // Индекс редактируемого будильника, если он существует
    var alarmIndex: Int?
    
    // Используем для управления закрытием экрана
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showingAlert = false
    
    var body: some View {
        ScrollView(.vertical) {
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
                        .font(.system(size: 18, weight: .light))
                        .foregroundColor(Color("StringColorSet"))
                    }
                    .padding(.top, 10)
                    .padding(.horizontal, 18)
                    
                    // MARK: - Time setup
                    DatePicker(
                        "",
                        selection: $alarmViewModel.time,
                        displayedComponents: .hourAndMinute
                    )
                    .padding(.top, 20)
                    .padding(.horizontal, 18)
                    .labelsHidden()
                    .datePickerStyle(.wheel)
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
                                if alarmViewModel.repeatDays.contains(day) {
                                    alarmViewModel.repeatDays.removeAll { $0 == day }
                                } else {
                                    alarmViewModel.repeatDays.append(day)
                                }
                            }) {
                                Text(day)
                                    .frame(width: 48, height: 48)
                                    .background(alarmViewModel.repeatDays.contains(day) ? Color("FramesColorSet") : Color("InactiveColorSet"))
                                    .foregroundColor(alarmViewModel.repeatDays.contains(day) ? Color("StringColorSet") : Color("StringColorSet").opacity(0.3))
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
                    .padding(.top, 20)
                    .padding(.horizontal, 18)
                    
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
                                Text("\(soundSettingsViewData.soundValue)")
                                    .font(.system(size: 18, weight: .light))
                                    .foregroundColor(Color("StringColorSet"))
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color("StringColorSet"))
                            }
                            .opacity(0.5)
                        }
                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 18)
                    
                    //MARK: - Delay
                    HStack {
                        Text("Delay:")
                            .font(.system(size: 18, weight: .light))
                            .foregroundColor(Color("StringColorSet"))
                        
                        Spacer()
                        
                        Picker(selection: $delayData.selectedDelay,
                               label: Text("\(delayData.selectedDelay) min")) {
                            ForEach(delayData.delayOptions, id: \.self) { delay in
                                Text("\(delay) min").tag(delay)
                            }
                        }
                               .pickerStyle(MenuPickerStyle())
                               .accentColor(Color("StringColorSet").opacity(0.5))
                        
                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 18)
                    
                    HStack {
                        Button(action: {
                            if let alarmIndex = alarmIndex {
                                // Редактирование существующего будильника
                                alarmViewModel.updateAlarm(at: alarmIndex)
                            } else {
                                // Создание нового будильника
                                alarmViewModel.addAlarm()
                            }
                            // Возвращаем пользователя на экран HomeView
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Save")
                                .frame(width: 120, height: 50)
                                .foregroundColor(Color("StringColorSet"))
                                .background(Color("ImportantColorSet"))
                                .cornerRadius(10)
                                .padding()
                        }
                        
                        Button(action: {
                            if let alarmIndex = alarmIndex {
                                // Удаление будильника
                                alarmViewModel.deleteAlarm(at: alarmIndex)
                                // Возвращаем пользователя на экран HomeView
                                presentationMode.wrappedValue.dismiss()
                            }
                        }) {
                            Text("Delete alarm")
                                .padding()
                                .foregroundColor(.red)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                    
                    Spacer()
                    
                }
            }
        }
        .background(Color("BackgroundColorSet"))
    }
}

#Preview {
    AlarmSettingsView(
        alarmViewModel: AlarmViewModel(),
        wakeUpIntervalData: WakeUpModel(),
        soundSettingsViewData: SoundSettingsViewModel(),
        delayData: DelayViewModel()
    )
}
