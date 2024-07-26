import SwiftUI

struct CustomDatePicker: View {
    @State private var selectedTime = Date()
    
    var body: some View {
        VStack {
            DatePicker("Select Time",
                       selection: $selectedTime,
                       displayedComponents: .hourAndMinute)
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
                .colorInvert() // Инвертирование цвета текста
                .frame(height: 200) // Установка высоты колесика
            
        }
        .padding()
        .background(Color.black) // Темный фон
        .cornerRadius(10)
    }
}

struct ContentView: View {
    var body: some View {
        CustomDatePicker()
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
