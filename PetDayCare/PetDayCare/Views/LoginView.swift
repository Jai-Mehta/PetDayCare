//
//  LoginView.swift
//  PetDayCare
//
//  Created by Jai Mehta on 3/26/25.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage: String?
    @Binding var isAuthenticated: Bool  // <-- Use binding to update auth state
    @State private var navigateToSignUp = false
    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "#AE6427").ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Text("WELCOME\nTO\nPETDAYCARE")
                        .font(.custom("MarkerFelt-Wide", size: 32))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color(hex: "#F9F3B9").opacity(0.3))
                        .cornerRadius(20)
                        .foregroundColor(.black)
                        .frame(width: 280, height: 50)
                        .font(.system(size: 18, weight: .bold))
                        .autocapitalization(.none)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(hex: "#F9F3B9").opacity(0.3))
                        .cornerRadius(20)
                        .foregroundColor(.black)
                        .frame(width: 280, height: 50)
                        .font(.system(size: 18, weight: .bold))
                    
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }
                    
                    Button(action: {
                        AuthService.shared.loginUser(email: email, password: password) { result in
                            switch result {
                            case .success(let user):
                                FirestoreService.shared.getUserProfile { userData, error in
                                    if let userData = userData {
                                        self.isAuthenticated = true  // <-- Update authentication state
                                    } else {
                                        self.errorMessage = "No user data found."
                                    }
                                }
                            case .failure(let error):
                                self.errorMessage = error.localizedDescription
                            }
                        }
                    }) {
                        Text("Login")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color(hex: "#8C6239"))
                            .frame(width: 150, height: 50)
                            .background(Color(hex: "#F9F3B9"))
                            .cornerRadius(25)
                    }
                    Button(action: {
                                            navigateToSignUp = true
                                        }) {
                                            Text("Don't have an account? Sign Up")
                                                .font(.system(size: 16, weight: .bold))
                                                .foregroundColor(Color(hex: "#F9F3B9"))
                                        }
                                        .padding(.bottom, 30)
                                        
                                        NavigationLink("", destination: SignUpView(isAuthenticated: $isAuthenticated), isActive: $navigateToSignUp)
                                    
                }
            }
        }
    }
}


