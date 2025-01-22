import Foundation

struct WidgetStore {
    static func getWeeksThisYear() -> Int {
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: Date())
        let startOfYear = calendar.date(from: DateComponents(year: currentYear))!
        let components = calendar.dateComponents([.weekOfYear], from: startOfYear, to: Date())
        return max(0, components.weekOfYear ?? 0)
    }
} 