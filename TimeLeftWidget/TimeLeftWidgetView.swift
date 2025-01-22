import SwiftUI
import WidgetKit

struct TimeLeftWidgetView: View {
    let weeksThisYear: Int
    
    // Calculate sizes to fit widget bounds
    private let dotSize: CGFloat = 10
    private let dotSpacing: CGFloat = 4
    private let horizontalPadding: CGFloat = 16
    private let columns = Array(repeating: GridItem(.fixed(10), spacing: 4), count: 10)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Weeks Left")
                .font(.custom("JetBrainsMono-ExtraBold", size: 16))
                .padding(.leading, horizontalPadding)
                .padding(.top, 16)
            
            LazyVGrid(columns: columns, spacing: dotSpacing) {
                ForEach(0..<52, id: \.self) { index in
                    Circle()
                        .fill(index < weeksThisYear ? Color.black : Color.gray.opacity(0.2))
                        .frame(width: dotSize, height: dotSize)
                }
            }
            .padding(.horizontal, horizontalPadding)
            Spacer(minLength: 16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.white)
    }
}

struct TimeLeftWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        TimeLeftWidgetView(weeksThisYear: 2)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
} 