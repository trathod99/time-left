import SwiftUI

struct SettingsView: View {
    @ObservedObject var store: SettingsStore
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Age Settings")) {
                    TextField("Current Age", text: $store.currentAge)
                        .autocapitalization(.none)
                        .keyboardType(.numberPad)
                    
                    TextField("End Age", text: $store.endAge)
                        .autocapitalization(.none)
                        .keyboardType(.numberPad)
                    
                    HStack {
                        Text("Years Remaining:")
                        Spacer()
                        Text("\(store.yearsRemaining)")
                            .foregroundColor(.blue)
                    }
                    
                    HStack {
                        Text("Weeks Remaining:")
                        Spacer()
                        Text("\(store.weeksRemaining)")
                            .foregroundColor(.blue)
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(store: SettingsStore())
    }
} 