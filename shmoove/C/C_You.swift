import Foundation
import Combine
import FirebaseAuth
import FirebaseCore
import AuthenticationServices
import GoogleSignIn
import JWTDecode
import Auth0
import SwiftUI

class C_You: ObservableObject {    
    @Published var email: String = ""
    @Published var token: Credentials?
    @Published var showLogin: Bool = true
    private var credentialsManager: CredentialsManager

    init() {
        let auth0 = Auth0.authentication()
        self.credentialsManager = CredentialsManager(authentication: auth0)
        
        self.getYouData()
    }
    
    func storeCredentials(cred: Credentials) {
        credentialsManager.store(credentials: cred)
    }
    
    func deleteCredentials() {
        credentialsManager.clear()
        token = nil // Clear the token
    }
    
    func getYouData() {
        if token == nil {
            print("info: getYouData() - token is missing, trying CredentialsManager | C_You")
            if credentialsManager.hasValid() {
                credentialsManager.credentials { result in
                    switch result {
                    case .success(let cred):
                        DispatchQueue.main.async {
                            // getting token from credentialmanager
                            self.token = cred
                            
                            // getting data
                            print("executing: getYouData() - with token \(String(describing: self.token)) | C_You")
                            guard let jwt = try? decode(jwt: self.token?.idToken ?? ""),
                                  let name = jwt["name"].string,
                                  let picture = jwt["picture"].string,
                                  let mail = jwt["email"].string else {
                                return
                            }
                            self.email = mail
                            
                            // changing screens
                            withAnimation {
                                self.showLogin = false
                            }
                        }
                    case .failure(let error):
                        print("error: getYouData() - unspecified error: \(error)")
                        DispatchQueue.main.async {
                            withAnimation {
                                self.showLogin = true
                            }
                        }
                    }
                }
            } else {
                print("info: getYouData() - CredentialsManager has no credentials for this session | C_You")
                DispatchQueue.main.async {
                    withAnimation {
                        self.showLogin = true
                    }
                }
            }
        } else {
            print("info: getYouData() - token exists | C_You")
            guard let jwt = try? decode(jwt: token?.idToken ?? ""),
                  let name = jwt["name"].string,
                  let picture = jwt["picture"].string,
                  let mail = jwt["email"].string else {
                return
            }
            self.email = mail
            
            // changing screens
            withAnimation {
                self.showLogin = false
            }
        }
    }

    func renewCredentials(completion: @escaping (Bool) -> Void) {
        guard let refreshToken = token?.refreshToken else {
            completion(false)
            return
        }
        
        Auth0.authentication()
            .renew(withRefreshToken: refreshToken)
            .start { result in
                switch result {
                case .success(let credentials):
                    self.token = credentials
                    completion(true)
                case .failure(let error):
                    print("Failed to renew credentials: \(error)")
                    completion(false)
                }
            }
    }
}
    
