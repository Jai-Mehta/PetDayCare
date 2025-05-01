//
//  ContentView.swift
//  PetDayCare
//
//  Created by Jai Mehta on 3/26/25.
//


import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @State private var isAuthenticated = false

    var body: some View {
        Group {
            if isAuthenticated {
                BeASitterView() // Show Home if user is logged in
            } else {
                LoginView(isAuthenticated: $isAuthenticated) // Pass authentication state
            }
        }
        .onAppear {
            checkAuthStatus() // Ensure authentication state is checked on app launch
        }
    }
    
    func checkAuthStatus() {
        Auth.auth().addStateDidChangeListener { auth, user in
            if user != nil {
                isAuthenticated = true
            } else {
                isAuthenticated = false
            }
        }
    }
}

