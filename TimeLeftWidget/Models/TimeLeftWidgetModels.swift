import WidgetKit

enum TimeLeftWidget {
    public struct SimpleEntry: TimelineEntry {
        public let date: Date
        public let weeksThisYear: Int
        public let weeksLived: Int
        public let totalWeeks: Int
        
        public init(date: Date, weeksThisYear: Int, weeksLived: Int, totalWeeks: Int) {
            self.date = date
            self.weeksThisYear = weeksThisYear
            self.weeksLived = weeksLived
            self.totalWeeks = totalWeeks
        }
    }

    public struct Provider: TimelineProvider {
        public typealias Entry = SimpleEntry
        
        public init() {}
        
        public func placeholder(in context: Context) -> SimpleEntry {
            SimpleEntry(date: Date(), weeksThisYear: 0, weeksLived: 0, totalWeeks: 52 * 80)
        }

        public func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
            let entry = SimpleEntry(
                date: Date(),
                weeksThisYear: WidgetStore.getWeeksThisYear(),
                weeksLived: WidgetStore.getWeeksLived(),
                totalWeeks: WidgetStore.getTotalWeeks()
            )
            completion(entry)
        }

        public func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
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
} 