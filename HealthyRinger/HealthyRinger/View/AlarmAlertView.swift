import SwiftUI

struct AlarmAlertView: View {
    
    var title: String
    var message: String
    var onDismiss: () -> Void
    
    var body: some View {
        VStack() {
           
            Spacer()
            
            Text(title)
                .font(.system(size: 38, weight: .light))
                .foregroundColor(Color("StringColorSet"))
          
            VStack {
                VStack {
                    Button(action: {
                        onDismiss()
                    }) {
                        VStack {
                            Image(systemName: "moon.zzz")
                                .resizable()
                                .frame(width: 50, height: 55)
                                .foregroundColor(Color("StringColorSet"))

                            Text("Snooze +10 min")
                                .font(.system(size: 28, weight: .light))
                                .foregroundColor(Color("StringColorSet"))
                            
                            Text("Alert again at 4:20")
                                .font(.system(size: 18, weight: .light))
                                .foregroundColor(Color("StringColorSet"))
                        }
                    }
                    .frame(maxWidth: .infinity,maxHeight: 400)
                    .foregroundColor(.white)
                    .background(Color("ImportantColorSet"))
                    .cornerRadius(35)
                    
                    Button(action: {
                        onDismiss()
                    }) {
                        VStack {
                            Image(systemName: "xmark.circle")
                                .font(.largeTitle)
                                .foregroundColor(Color("StringColorSet"))

                            Text("Stop")
                                .font(.system(size: 28, weight: .light))
                                .foregroundColor(Color("StringColorSet"))
                        }
                    }
                    .frame(maxWidth: .infinity,maxHeight: 100)
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(35)
                }
                .padding(.bottom, 20)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .padding()
    }
}

// Main Content View
struct ContentView: View {
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            Button("Show Alert") {
                showAlert = true
            }
            .padding()
            
            if showAlert {
                AlarmAlertView(
                    title: "First Alarm",
                    message: "Your alarm is going off. It's time to start your day!",
                    onDismiss: {
                        showAlert = false
                    }
                )
                .transition(.opacity)
            }
        }
        .animation(.easeInOut, value: showAlert)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
