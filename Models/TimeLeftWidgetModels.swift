import WidgetKit

struct SimpleEntry: TimelineEntry {
    let date: Date
    let weeksThisYear: Int
    let weeksLived: Int
    let totalWeeks: Int
}

struct Provider: TimelineProvider {
    typealias Entry = SimpleEntry
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), weeksThisYear: 0, weeksLived: 0, totalWeeks: 52 * 80)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(
            date: Date(),
            weeksThisYear: WidgetStore.getWeeksThisYear(),
            weeksLived: WidgetStore.getWeeksLived(),
            totalWeeks: WidgetStore.getTotalWeeks()
        )
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        var entries: [SimpleEntry] = []
        let currentDate = Date()
        let entry = SimpleEntry(
            date: currentDate,
            weeksThisYear: WidgetStore.getWeeksThisYear(),
            weeksLived: WidgetStore.getWeeksLived(),
            totalWeeks: WidgetStore.getTotalWeeks()
        )
        entries.append(entry)
        
        let midnight = Calendar.current.startOfDay(for: currentDate)
        let nextMidnight = Calendar.current.date(byAdding: .day, value: 1, to: midnight)!
        
        let timeline = Timeline(entries: entries, policy: .after(nextMidnight))
        completion(timeline)
    }
}
