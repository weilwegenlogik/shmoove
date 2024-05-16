//
//  V_Home_Search.swift
//  shmoove
//
//  Created by Jakob Schulze on 09.05.24.
//

import SwiftUI
import Awesome

struct V_Home_You: View {
    // StateObject vars
    @StateObject private var c_auth = C_Auth()
    @StateObject private var c_you = C_You()
    
    var body: some View {
        VStack {
            Text(c_you.email)
            V_Link_Button_Spotify()
        }
        .refreshable {
            c_you.getYouData()
        }
    }
}

#Preview {
    V_Home_You()
}

struct V_Link_Button_Spotify: View {
    @StateObject private var c_auth = C_Auth()
    @StateObject private var c_you = C_You()

    var body: some View {
        Button(action: {
            //c_you.linkSpotify()
            c_you.getYouData()
        }, label: {
            HStack {
                Spacer()
                Awesome.Brand.spotify.image
                    .foregroundColor(.white)
                Text("Sign in with Spotify")
                    .foregroundStyle(.white)
                Spacer()
            }
        })
        .padding(15.0)
        .background(Color.white.opacity(0.1))
        .cornerRadius(90)
        .frame(maxWidth: 235)
        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
    }
}
