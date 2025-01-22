import SwiftUI

struct HomeView: View {
    @ObservedObject var store: SettingsStore
    @State private var selectedView = 0
    
    let weekColumns = Array(repeating: GridItem(.fixed(5), spacing: 2), count: 52)
    let yearWeekColumns = Array(repeating: GridItem(.fixed(30), spacing: 8), count: 10)
    
    // Calculate month dot size dynamically
    private func monthItemSize(in geometry: GeometryProxy) -> CGFloat {
        let horizontalPadding: CGFloat = 40  // Total horizontal padding (20 on each side)
        let spacing: CGFloat = 2  // Spacing between dots
        let columns: CGFloat = 36 // Number of dots per row
        
        // Available width minus padding, divided by columns, minus spacing
        let size = (geometry.size.width - horizontalPadding - (spacing * (columns - 1))) / columns
        return floor(size) // Round down to ensure fit
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                let monthDotSize = monthItemSize(in: geometry)
                let monthColumns = Array(repeating: GridItem(.fixed(monthDotSize), spacing: 2), count: 36)
                
                TabView(selection: $selectedView) {
                    // Weeks this year View
                    ScrollView {
                        Spacer(minLength: 50)
                        LazyVGrid(columns: yearWeekColumns, spacing: 8) {
                            ForEach(0..<52, id: \.self) { index in
                                Circle()
                                    .fill(index < store.weeksThisYear ? Color.black : Color.gray.opacity(0.3))
                                    .frame(width: 30, height: 30)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        Spacer(minLength: 50)
                    }
                    .tag(0)
                    .navigationTitle("Weeks this Year")
                    
                    // Life in Weeks View
                    ScrollView {
                        LazyVGrid(columns: weekColumns, spacing: 2) {
                            ForEach(0..<(store.endAgeValue * 52), id: \.self) { index in
                                Circle()
                                    .fill(index < store.weeksLived ? Color.black : Color.gray.opacity(0.3))
                                    .frame(width: 5, height: 5)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                    }
                    .tag(1)
                    .navigationTitle("Life in Weeks")
                    
                    // Months View
                    ScrollView {
                        LazyVGrid(columns: monthColumns, spacing: 2) {
                            ForEach(0..<(store.endAgeValue * 12), id: \.self) { index in
                                Circle()
                                    .fill(index < store.monthsLived ? Color.black : Color.gray.opacity(0.3))
                                    .frame(width: monthDotSize, height: monthDotSize)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                    }
                    .tag(2)
                    .navigationTitle("Life in Months")
                }
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(store: SettingsStore())
    }
} 