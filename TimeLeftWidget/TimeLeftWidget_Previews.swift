import SwiftUI
import WidgetKit

struct TimeLeftWidget_Previews: PreviewProvider {
    static var previews: some View {
        TimeLeftWidgetEntryView(entry: SimpleEntry(date: Date(), weeksThisYear: 26))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
} 