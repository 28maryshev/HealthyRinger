import SwiftUI
import AVFoundation

class AlarmViewModel: ObservableObject {
    @Published var isAlarmOn: Bool = true
    @Published var selectedDays: [String] = []
    @Published var alarmName: String = "Alarm 1"
    @Published var alarmTime: Date = Date()
    
    @Published var selectedInterval: Int = 60
    @Published var intervalOptions: [Int] = [30, 60, 120]
    
    @Published var soundValue: String = "Light tone (default)"
    
    @Published var week: [String] = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"]
}

//MARK: - Alarm Widget
struct AlarmView: View {
    @ObservedObject var alarmViewModel: AlarmViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading) {
                Text(alarmViewModel.alarmName)
                    .font(.caption)
                    .foregroundColor(.gray)
                HStack {
                    Text(alarmViewModel.alarmTime, style: .time)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                    Toggle("", isOn: $alarmViewModel.isAlarmOn)
                        .labelsHidden()
                }
                Text("SUN, MON, TUE")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color("FramesColorSet"))
            .cornerRadius(10)
        }
        .padding()
        .edgesIgnoringSafeArea(.all)
    }
}

//MARK: Wake-up Interval struct
struct WakeUpInterval: View {
    @Binding var alarmTime: Date
    var interval: Int
    
    @State var firstPosition: CGFloat = 70
    @State var secondPosition: CGFloat = 290
    
    var body: some View {
        let calendar = Calendar.current
        let minusTwoTime = calendar.date(byAdding: .minute, value: -2 * interval/2, to: alarmTime) ?? alarmTime
        let minusOneTime = calendar.date(byAdding: .minute, value: -interval/2, to: alarmTime) ?? alarmTime
        let plusOneTime = calendar.date(byAdding: .minute, value: interval/2, to: alarmTime) ?? alarmTime
        let plusTwoTime = calendar.date(byAdding: .minute, value: 2 * interval/2, to: alarmTime) ?? alarmTime
        
        VStack {
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color("ImportantColorSet").opacity(0.20))
                    .frame(height: 26)
                    .cornerRadius(15)
                
                Rectangle()
                    .fill(Color("ImportantColorSet"))
                    .cornerRadius(15)
                    .frame(width: self.secondPosition - self.firstPosition, height: 30)
                    .offset(x: self.firstPosition)
                
                GeometryReader { geometry in
                    Text(minusTwoTime, style: .time)
                        .foregroundStyle(Color("StringColorSet"))
                        .position(x: self.firstPosition - 35, y: geometry.size.height / 2)
                        .opacity(0.5)
                    
                    Text(minusOneTime, style: .time)
                        .foregroundStyle(Color("StringColorSet"))
                        .position(x: self.firstPosition + 30, y: geometry.size.height / 2)
                    
                    Text(alarmTime, style: .time)
                        .foregroundColor(Color("StringColorSet"))
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    
                    Text(plusOneTime, style: .time)
                        .foregroundStyle(Color("StringColorSet"))
                        .position(x: self.secondPosition - 30, y: geometry.size.height / 2)
                    
                    Text(plusTwoTime, style: .time)
                        .foregroundStyle(Color("StringColorSet"))
                        .position(x: self.secondPosition + 35, y: geometry.size.height / 2)
                        .opacity(0.5)
                }
                .frame(height: 30)
            }
        }
        .padding([.leading, .trailing], 20)
    }
}

//MARK: - SoundSettingsView struct
struct SoundSettingsView: View {
    
    @State private var audioPlayer: AVAudioPlayer?
    @State var sound: [SoundModel] = [
        SoundModel(name: "Street.wav"),
        SoundModel(name: "Piano.wav"),
        SoundModel(name: "Bells.mp3")]
    
    var body: some View {
                ZStack {
                    Color("BackgroundColorSet").ignoresSafeArea()
                    
                    List(sound) { sound in
                        Button {
                            playSound(named: sound.name)
                        } label: {
                            Text(removeFileExtension(from: sound.name))
                        }
                        .listRowBackground(Color("FramesColorSet"))
                        .foregroundColor(Color("StringColorSet"))
                    }
                    .background(Color("BackgroundColorSet"))
                    .scrollContentBackground(.hidden)
                }
            }
            
            func playSound(named soundName: String) {
                let path = "/Users/vladimirmarysev/Documents/Swift/HealthyRinger/HealthyRinger/HealthyRinger/Sounds/\(soundName)"
                let url = URL(fileURLWithPath: path)
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: url)
                    audioPlayer?.play()
                } catch {
                    print("Error loading and playing sound: \(error.localizedDescription)")
                }
            }
            
            func removeFileExtension(from fileName: String) -> String {
                return (fileName as NSString).deletingPathExtension
            }
}


//MARK: - START VIEW
struct AlarmSettingsView: View {
    @ObservedObject var alarmViewModel: AlarmViewModel
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
                        
                        Picker(selection: $alarmViewModel.selectedInterval, label: Text("\(alarmViewModel.selectedInterval) min")) {
                            ForEach(alarmViewModel.intervalOptions, id: \.self) { interval in
                                Text("\(interval) min").tag(interval)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .accentColor(Color("StringColorSet").opacity(0.5))
                        
                    }
                    .padding()
                    
                    WakeUpInterval(alarmTime: $alarmViewModel.alarmTime, interval: alarmViewModel.selectedInterval)
                    
                    HStack {
                        Text("Sound:")
                            .font(.system(size: 18, weight: .light))
                            .foregroundColor(Color("StringColorSet"))
                        
                        Spacer()
                        
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
    AlarmSettingsView(alarmViewModel: AlarmViewModel())
}
