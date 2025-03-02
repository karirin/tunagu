//
//  AuthManager.swift
//  tunagu
//
//  Created by Apple on 2025/03/01.
//

import SwiftUI
import Firebase

class AuthManager: ObservableObject {
    @Published var user: FirebaseAuth.User? {
        willSet {
            objectWillChange.send()
        }
    }
    var onLoginCompleted: (() -> Void)?
    
    init() {
        user = Auth.auth().currentUser
    }
    
    var currentUserId: String? {
        print("user?.uid:\(user?.uid)")
        return user?.uid
    }
    
    func anonymousSignIn(completion: @escaping () -> Void) {
        Auth.auth().signInAnonymously { result, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else if let result = result {
                print("Signed in anonymously with user ID: \(result.user.uid)")
                self.onLoginCompleted?()
            }
            completion()
        }
    }
}

struct AuthManager1: View {
    @ObservedObject var authManager = AuthManager()

    var body: some View {
        VStack {
            if authManager.user == nil {
                Text("Not logged in")
            } else {
                Text("Logged in with user ID: \(authManager.user!.uid)")
            }
            Button(action: {
                if self.authManager.user == nil {
                    self.authManager.anonymousSignIn(){}
                }
            }) {
                Text("Log in anonymously")
            }
        }
    }
}

struct AuthManager_Previews: PreviewProvider {
    static var previews: some View {
        AuthManager1()
    }
}
