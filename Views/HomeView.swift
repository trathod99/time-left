import SwiftUI

struct HomeView: View {
    @ObservedObject var store: SettingsStore
    
    let columns = Array(repeating: GridItem(.fixed(5), spacing: 2), count: 52)
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 2) {
                    ForEach(0..<(store.endAgeValue * 52), id: \.self) { index in
                        Circle()
                            .fill(index < store.weeksLived ? Color.black : Color.gray.opacity(0.3))
                            .frame(width: 5, height: 5)
                    }
                }
                .padding()
            }
            .navigationTitle("Life in Weeks")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(store: SettingsStore())
    }
} 