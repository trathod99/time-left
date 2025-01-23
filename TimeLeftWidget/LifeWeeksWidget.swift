import WidgetKit
import SwiftUI

struct LifeWeeksWidget: Widget {
    let kind: String = "LifeWeeksWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: TimeLeftWidget.Provider()) { entry in
            LifeWeeksWidgetView(
                weeksThisYear: entry.weeksThisYear,
                weeksLived: entry.weeksLived,
                totalWeeks: entry.totalWeeks
            )
        }
        .configurationDisplayName("Weeks Progress")
        .description("See your weekly progress visualized.")
        .supportedFamilies([.systemMedium])
    }
}
