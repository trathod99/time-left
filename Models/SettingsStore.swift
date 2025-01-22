import SwiftUI

final class SettingsStore: ObservableObject {
    @Published var birthday: Date = Calendar.current.date(byAdding: .year, value: -30, to: Date()) ?? Date()
    @Published var endAge: String = "80"
    
    var currentAge: Int {
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthday, to: Date())
        return ageComponents.year ?? 0
    }
    
    var weeksLived: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekOfYear], from: birthday, to: Date())
        return max(0, components.weekOfYear ?? 0)
    }
    
    var weeksThisYear: Int {
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: Date())
        let startOfYear = calendar.date(from: DateComponents(year: currentYear))!
        let components = calendar.dateComponents([.weekOfYear], from: startOfYear, to: Date())
        return max(0, components.weekOfYear ?? 0)
    }
    
    var monthsLived: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month], from: birthday, to: Date())
        return max(0, components.month ?? 0)
    }
    
    var endAgeValue: Int {
        return Int(endAge) ?? 0
    }
    
    var yearsRemaining: Int {
        return max(0, endAgeValue - currentAge)
    }
    
    var weeksRemaining: Int {
        return yearsRemaining * 52
    }
    
    var monthsRemaining: Int {
        return yearsRemaining * 12
    }
} 