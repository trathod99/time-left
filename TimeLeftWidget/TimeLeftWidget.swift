import WidgetKit
import SwiftUI

struct SimpleEntry: TimelineEntry {
    let date: Date
    let weeksThisYear: Int
}

struct Provider: TimelineProvider {
    typealias Entry = SimpleEntry
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), weeksThisYear: 0)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), weeksThisYear: WidgetStore.getWeeksThisYear())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        // Update at midnight each day
        var entries: [SimpleEntry] = []
        let currentDate = Date()
        let weeksThisYear = WidgetStore.getWeeksThisYear()
        
        let midnight = Calendar.current.startOfDay(for: currentDate)
        let nextMidnight = Calendar.current.date(byAdding: .day, value: 1, to: midnight)!
        
        let entry = SimpleEntry(date: currentDate, weeksThisYear: weeksThisYear)
        entries.append(entry)
        
        let timeline = Timeline(entries: entries, policy: .after(nextMidnight))
        completion(timeline)
    }
}

struct TimeLeftWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        TimeLeftWidgetView(weeksThisYear: entry.weeksThisYear)
    }
}

struct TimeLeftWidget: Widget {
    let kind: String = "TimeLeftWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            TimeLeftWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Time Left")
        .description("See how many weeks are left this year.")
        .supportedFamilies([.systemSmall])
    }
} 