import SwiftUI

final class SettingsStore: ObservableObject {
    @Published var currentAge: String = "0"
    @Published var endAge: String = "0"
    
    var endAgeValue: Int {
        return Int(endAge) ?? 0
    }
    
    var currentAgeValue: Int {
        return Int(currentAge) ?? 0
    }
    
    var yearsRemaining: Int {
        return max(0, endAgeValue - currentAgeValue)
    }
    
    var weeksRemaining: Int {
        return yearsRemaining * 52
    }
} 