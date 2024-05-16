//
//  V_Home.swift
//  shmoove
//
//  Created by Jakob Schulze on 09.05.24.
//

import SwiftUI

struct V_Home: View {
    @State var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab,
                content:  {
            V_Home_Home().tabItem {
                Image(systemName: "house")
                Text("Home")
            }.tag(0)
            
            V_Home_You().tabItem {
                Image(systemName: "person")
                Text("You")
            }.tag(1)
            
            V_Home_Causes().tabItem {
                Image(systemName: "megaphone")
                Text("Causes")
            }.tag(1)
            
            V_Home_Friends().tabItem {
                Image(systemName: "person.2")
                Text("Friends")
            }.tag(1)
            
            V_Home_Settings().tabItem {
                Image(systemName: "gear")
                Text("Settings")
            }.tag(1)
        })
    }
}

#Preview {
    V_Home()
}
