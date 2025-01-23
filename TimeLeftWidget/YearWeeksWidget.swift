import WidgetKit
import SwiftUI

struct YearWeeksWidgetView : View {
    let entry: TimeLeftWidget.SimpleEntry

    var body: some View {
        TimeLeftWidgetView(weeksThisYear: entry.weeksThisYear)
    }
}

struct YearWeeksWidget: Widget {
    let kind: String = "YearWeeksWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: TimeLeftWidget.Provider()) { entry in
            YearWeeksWidgetView(entry: entry)
        }
        .configurationDisplayName("Weeks of Year")
        .description("See weeks completed in the current year.")
        .supportedFamilies([.systemSmall])
    }
}
