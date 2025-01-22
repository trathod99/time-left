import SwiftUI
import WidgetKit

struct TimeLeftWidgetView: View {
    let weeksThisYear: Int
    
    private let columns = Array(repeating: GridItem(.fixed(12), spacing: 4), count: 10)
    
    var body: some View {
        VStack {
            Text("Weeks this Year")
                .font(.caption)
                .padding(.bottom, 4)
            
            LazyVGrid(columns: columns, spacing: 4) {
                ForEach(0..<52, id: \.self) { index in
                    Circle()
                        .fill(index < weeksThisYear ? Color.black : Color.gray.opacity(0.3))
                        .frame(width: 12, height: 12)
                }
            }
            .padding(.horizontal, 8)
        }
        .padding(.vertical, 8)
    }
} 