//
//  V_Home_Settings.swift
//  shmoove
//
//  Created by Jakob Schulze on 09.05.24.
//

import SwiftUI
import Auth0

struct V_Home_Settings: View {
    // StateObject vars
    @StateObject private var c_auth = C_Auth()
    @StateObject private var c_you = C_You()
    
    // State vars
    
    var body: some View {
        VStack {
            Spacer()
            Text("Home")
            Spacer()
            HStack {
                Button(action: {
                    Auth0
                        .webAuth()
                        .useHTTPS() // Use a Universal Link logout URL on iOS 17.4+ / macOS 14.4+
                        .clearSession { result in
                            switch result {
                            case .success:
                                print("Logged out")
                                c_you.deleteCredentials()
                                withAnimation {
                                    c_you.showLogin = true
                                }
                            case .failure(let error):
                                print("Failed with: \(error)")
                            }
                        }
                }, label: {
                    Text("Logout")
                        .foregroundStyle(.black)
                        .fontWeight(.bold)
                        .padding(15)
                        .background(.white)
                        .cornerRadius(45)
                        .padding()
                })
            }
        }
    }
}
