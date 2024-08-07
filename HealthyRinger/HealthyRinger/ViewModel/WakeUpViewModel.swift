import Foundation
import SwiftUI

class WakeUpModel: ObservableObject {
    @Published var selectedInterval: Int = 60
    @Published var intervalOptions: [Int] = [30, 60, 120]
    @Published var alarmTime: Date = Date()
}

struct WakeUpInterval: View {
    @ObservedObject var wakeUpIntervalData: WakeUpModel
    @ObservedObject var alarmData: AlarmViewModel
    
    @State var firstPosition: CGFloat = 70
    @State var secondPosition: CGFloat = 290
    
    var body: some View {
        let calendar = Calendar.current
        let minusTwoTime = calendar.date(byAdding: .minute, value: -2 * wakeUpIntervalData.selectedInterval/2, to: wakeUpIntervalData.alarmTime) ?? wakeUpIntervalData.alarmTime
        let minusOneTime = calendar.date(byAdding: .minute, value: -wakeUpIntervalData.selectedInterval/2, to: wakeUpIntervalData.alarmTime) ?? wakeUpIntervalData.alarmTime
        let plusOneTime = calendar.date(byAdding: .minute, value: wakeUpIntervalData.selectedInterval/2, to: wakeUpIntervalData.alarmTime) ?? wakeUpIntervalData.alarmTime
        let plusTwoTime = calendar.date(byAdding: .minute, value: 2 * wakeUpIntervalData.selectedInterval/2, to: wakeUpIntervalData.alarmTime) ?? wakeUpIntervalData.alarmTime
        
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
                    
                    Text(wakeUpIntervalData.alarmTime, style: .time)
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

#Preview {
    WakeUpInterval(
        wakeUpIntervalData: WakeUpModel(),
        alarmData: AlarmViewModel()
    )
}
