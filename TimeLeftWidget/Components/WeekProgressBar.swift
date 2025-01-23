import SwiftUI

struct WeekProgressBar: View {
    let progress: Double // 0.0 to 1.0
    
    var body: some View {
        GeometryReader { geometry in
            let fillWidth = max(0, min(geometry.size.width * progress, geometry.size.width))
            
            ZStack(alignment: .leading) {
                // Background
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(white: 0.96)) // Light gray background
                
                // Progress
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(white: 0.7)) // Darker gray for better visibility
                    .frame(width: fillWidth)
            }
            .onAppear {
                print("Progress: \(progress), Fill width: \(fillWidth), Total width: \(geometry.size.width)")
            }
        }
        .frame(height: 32)
    }
} 