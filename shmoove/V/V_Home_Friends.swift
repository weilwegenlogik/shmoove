//
//  V_Home_Friends.swift
//  shmoove
//
//  Created by Jakob Schulze on 09.05.24.
//

import SwiftUI

struct V_Home_Friends: View {
    
    
    // StateObject vars
    @StateObject private var c_auth = C_Auth()
    @State var searchContent: String = ""
    
    var body: some View {
        VStack {
            HStack {
                TextField(text: $searchContent) {
                    HStack {
                        Text("Find your friends")
                    }
                }
                .padding(10)
                .background(.white.opacity(0.1))
                .cornerRadius(45)
                
            }
            .padding()
            Spacer()
            Image(systemName: "person.2")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, 150)
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            Text("No friends?")
                .fontWeight(.bold)
                .font(.title)
            Text("Discover new friends.")
            Text("Discovery feature coming soon.")
                .font(.footnote)
                .fontWeight(.light)
            Spacer()
        }.onTapGesture {
            self.endTextEditing()
        }
    }
}

#Preview {
    V_Home_Friends()
}
