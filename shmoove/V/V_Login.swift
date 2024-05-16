//
//  V_Login.swift
//  shmoove
//
//  Created by Jakob Schulze on 05.05.24.
//

import SwiftUI
import Awesome
import Auth0

struct V_Login: View {
    // StateObject vars
    @StateObject private var c_auth = C_Auth()
    @StateObject private var c_you = C_You()

    // State vars
    @State private var email = ""
    @State private var password = ""
        
    var body: some View {
        VStack {
            HStack {
                Image("shmoove")
                    .resizable()
                    .frame(width: 50, height: 50)
                VStack {
                    Text("welcome to shmoove!")
                        .font(.title)
                        .fontWeight(.bold)
                        Text("you need to authenticate to continue")
                }
            }
            
            Button(action: {
                Auth0
                    .webAuth()
                    .useHTTPS() // Use a Universal Link callback URL on iOS 17.4+ / macOS 14.4+
                    .start { result in
                        switch result {
                        case .success(let credentials):
                            print("Obtained credentials: \(credentials)")
                            c_you.token = credentials
                            c_you.storeCredentials(cred: credentials)
                            c_you.getYouData()
                            withAnimation {
                                c_you.showLogin = false
                                
                            }
                        case .failure(let error):
                            print("Failed with: \(error)")
                        }
                    }
            }, label: {
                HStack {
                    Spacer()
                    Text("Authenticate")
                        .foregroundStyle(.white)
                    Spacer()
                }
            })
            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            .padding(15.0)
            .background(Color.white.opacity(0.1))
            .cornerRadius(90)
            .frame(maxWidth: 235)
            .padding(.top, 20)
            
            /*if c_auth.isSignUpMode {
                Text("sign up the traditional way")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                TextField("your email here", text: $c_auth.email)
                    .padding(15.0)
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(90)
                    .frame(maxWidth: 230)
                
                SecureField("your password here", text: $c_auth.password)
                    .padding(15.0)
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(90)
                    .frame(maxWidth: 230)
                
                SecureField("confirm your password", text: $c_auth.passwordConfirmation)
                    .padding(15.0)
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(90)
                    .frame(maxWidth: 230)
            } else if c_auth.isSignInMode {
                Text("sign in the traditional way")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                TextField("your email here", text: $c_auth.email)
                    .padding(15.0)
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(90)
                    .frame(maxWidth: 230)
                
                SecureField("your password here", text: $c_auth.password)
                    .padding(15.0)
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(90)
                    .frame(maxWidth: 230)
            } else {
                Text("the traditional way")
                    .font(.title2)
                    .fontWeight(.semibold)
                TextField("your email here", text: $c_auth.email)
                    .padding(15.0)
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(90)
                    .frame(maxWidth: 230)
                    .onChange(of: c_auth.email) { oldValue, newValue in
                        if c_auth.validateEmail() {
                            c_auth.checkIfEmailExists { succ in
                                if succ {
                                    print("account does exist")
                                } else {
                                    print("account does not exist, redirecting to sign up")
                                }
                            }
                        }
                    }
            }
            
            
            
            
            Button(action: {
                if c_auth.isSignInMode {
                    c_auth.signIn { success in
                        if success {
                            print("signed in successfully")
                        }
                    }
                } else if c_auth.isSignUpMode {
                    c_auth.signUp { success in
                        if success {
                            print("signed up with email successfully")
                        }
                    }
                }
            }, label: {
                HStack {
                    Spacer()
                    if c_auth.isSignInMode {
                        Text("Sign in")
                            .foregroundStyle(.white)
                    } else if c_auth.isSignUpMode {
                        Text("Sign up")
                            .foregroundStyle(.white)
                    } else {
                        Text("Continue")
                            .foregroundStyle(.white)
                    }
                    Spacer()
                }
            })
            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            .padding(15.0)
            .background(Color.white.opacity(0.1))
            .cornerRadius(90)
            .frame(maxWidth: 235)
            .padding(.top, 20)
            
            if !c_auth.isSignInMode || !c_auth.isSignUpMode {
                Text("(we'll always remember you)")
                    .foregroundStyle(.gray)
                    .font(.footnote)
                    .fontWeight(.light)
            }
                
            if !c_auth.isSignUpMode {
                Divider()
                    .background(Color.gray.opacity(0.5)) // Adjust opacity for lighter gray
                    .padding()

                Text("sign in with other providers")
                    .font(.title2)
                    .fontWeight(.semibold)
                V_Login_Button_Apple()
                V_Login_Button_Google()
                V_Login_Button_Github()
            }
             */
        }
        .ignoresSafeArea(.keyboard)
        .onTapGesture {
                    self.hideKeyboard()
                }
    }
    
    private func hideKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    V_Login()
}
