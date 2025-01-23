import SwiftUI
import WidgetKit

final class SettingsStore: ObservableObject {
    // Keys for UserDefaults
    private let birthdayKey = "userBirthday"
    private let endAgeKey = "userEndAge"
    
    // Use shared UserDefaults through App Group
    private let shared = UserDefaults(suiteName: "group.com.tyler.timeleft")
    
    // Use property wrapper with willSet to save changes
    @Published var birthday: Date {
        willSet {
            shared?.set(newValue, forKey: birthdayKey)
            // Reload widget timeline when birthday changes
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
    
    @Published var endAge: String {
        willSet {
            shared?.set(newValue, forKey: endAgeKey)
            // Reload widget timeline when end age changes
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
    
    init() {
        // Load saved birthday or use default
        if let savedBirthday = shared?.object(forKey: birthdayKey) as? Date {
            self.birthday = savedBirthday
        } else {
            self.birthday = Calendar.current.date(byAdding: .year, value: -30, to: Date()) ?? Date()
        }
        
        // Load saved end age or use default
        if let savedEndAge = shared?.string(forKey: endAgeKey) {
            self.endAge = savedEndAge
        } else {
            self.endAge = "80"
        }
    }
    
    var currentAge: Int {
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthday, to: Date())
        return ageComponents.year ?? 0
    }
    
    var weeksLived: Int {
        let calendar = Calendar.current
        let now = Date()
        let components = calendar.dateComponents([.day], from: birthday, to: now)
        let days = components.day ?? 0
        return days / 7
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