import SwiftUI
import WidgetKit

struct LifeWeeksWidgetView: View {
    let weeksThisYear: Int
    let weeksLived: Int
    let totalWeeks: Int
    
    private var yearProgress: Double {
        let progress = Double(weeksThisYear) / 52.0
        print("Year progress calculation:")
        print("Weeks this year: \(weeksThisYear)")
        print("Progress: \(progress)")
        return progress
    }
    
    private var lifeProgress: Double {
        let progress = Double(weeksLived) / Double(totalWeeks)
        print("Life progress calculation:")
        print("Weeks lived: \(weeksLived)")
        print("Total weeks: \(totalWeeks)")
        print("Progress: \(progress)")
        return progress
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) { // Spacing between sections
            // Year progress section
            VStack(alignment: .leading, spacing: 8) { // Spacing between title and bar
                Text("Weeks of \(Calendar.current.component(.year, from: Date()))")
                    .font(.custom("JetBrainsMono-ExtraBold", size: 16))
                WeekProgressBar(progress: yearProgress)
            }
            
            // Life progress section
            VStack(alignment: .leading, spacing: 8) { // Spacing between title and bar
                Text("Weeks of your life")
                    .font(.custom("JetBrainsMono-ExtraBold", size: 16))
                WeekProgressBar(progress: lifeProgress)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.white)
    }
} 