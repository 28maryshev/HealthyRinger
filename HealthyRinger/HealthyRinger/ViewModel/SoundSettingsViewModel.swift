import Foundation
import SwiftUI
import AVFoundation

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

#Preview {
    SoundSettingsView()
}

