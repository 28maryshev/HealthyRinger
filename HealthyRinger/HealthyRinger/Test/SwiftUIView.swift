//import SwiftUI
//
//struct ContentView: View {
//    @State private var selectedDelay: Int = 10
//    let delayOptions: [Int] = [10, 15, 25]
//    
//    var body: some View {
//        NavigationView {
//            List {
//                NavigationLink(destination: SoundSettingsView()) {
//                    SettingRowView(settingName: "Sound", settingValue: "Light tone (default)")
//                }
//                
//                // Delay settings row with a Picker
//                HStack {
//                    Text("Delay:")
//                        .foregroundColor(.white)
//                    Spacer()
//                    Picker(selection: $selectedDelay, label: Text("\(selectedDelay) min")) {
//                        ForEach(delayOptions, id: \.self) { delay in
//                            Text("\(delay) min").tag(delay)
//                        }
//                    }
//                    .pickerStyle(MenuPickerStyle())
//                    .foregroundColor(.gray)
//                }
//                .padding()
//                .background(Color.black)
//            }
//            .navigationTitle("Settings")
//        }
//    }
//}
//
//struct SettingRowView: View {
//    var settingName: String
//    var settingValue: String
//    
//    var body: some View {
//        HStack {
//            Text("\(settingName):")
//                .foregroundColor(.white)
//            Spacer()
//            Text(settingValue)
//                .foregroundColor(.gray)
//        }
//        .padding()
//        .background(Color.black)
//    }
//}
//
//struct SoundSettingsView: View {
//    var body: some View {
//        Text("Sound Settings")
//            .navigationTitle("Sound")
//            .background(Color.black)
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
