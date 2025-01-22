//
//  Time_LeftApp.swift
//  Time Left
//
//  Created by Tyler Rathod on 1/21/25.
//

import SwiftUI

@main
struct Time_LeftApp: App {
    @StateObject private var store = SettingsStore()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                HomeView(store: store)
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                
                SettingsView(store: store)
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
            }
        }
    }
}
