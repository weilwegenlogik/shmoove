//
//  ContentView.swift
//  shmoove
//
//  Created by Jakob Schulze on 05.05.24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var c_you = C_You()
    
    var body: some View {
        VStack {
            if !c_you.showLogin {
                V_Home()
            } else {
                V_Login()
            }
        }
        .padding()
        .onAppear(perform: {
            c_you.getYouData()
        })
        .refreshable {
            c_you.getYouData()
        }
        .onChange(of: c_you.showLogin) { oldValue, newValue in
            print("Old value: \(oldValue), new value: \(newValue)")
        }
        
    }
}

#Preview {
    ContentView().environmentObject(C_Auth()) // For previews
}
