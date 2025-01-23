import Foundation

struct WidgetStore {
    // Use shared UserDefaults through App Group
    private static let shared = UserDefaults(suiteName: "group.com.tyler.timeleft")
    
    static func getWeeksThisYear() -> Int {
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: Date())
        let startOfYear = calendar.date(from: DateComponents(year: currentYear))!
        let components = calendar.dateComponents([.weekOfYear], from: startOfYear, to: Date())
        return max(0, components.weekOfYear ?? 0)
    }
    
    static func getWeeksLived() -> Int {
        if let birthday = shared?.object(forKey: "userBirthday") as? Date {
            let calendar = Calendar.current
            let now = Date()
            
            // First, let's print the actual birthday for debugging
            print("Debug - Birthday: \(birthday)")
            print("Debug - Current date: \(now)")
            
            // Calculate total days then convert to weeks
            let components = calendar.dateComponents([.day], from: birthday, to: now)
            let days = components.day ?? 0
            let weeks = days / 7
            
            print("Debug - Days lived: \(days)")
            print("Debug - Calculated weeks: \(weeks)")
            return weeks
        }
        print("Debug - No birthday found in Shared UserDefaults")
        return 0
    }
    
    static func getTotalWeeks() -> Int {
        if let endAgeString = shared?.string(forKey: "userEndAge"),
           let endAge = Int(endAgeString) {
            let totalWeeks = endAge * 52
            print("Debug - Total weeks in life: \(totalWeeks)")
            return totalWeeks
        }
        let defaultWeeks = 80 * 52
        print("Debug - Using default total weeks: \(defaultWeeks)")
        return defaultWeeks // Default to 80 years
    }
} 