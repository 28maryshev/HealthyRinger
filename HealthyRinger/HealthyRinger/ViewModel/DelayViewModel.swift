import Foundation
import SwiftUI

class DelayViewModel: ObservableObject {
    @Published var delayOptions: [Int] = [2, 3, 5, 10, 15, 20]
    @Published var selectedDelay: Int = 5
}


