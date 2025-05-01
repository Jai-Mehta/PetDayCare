//
//  LoginView.swift
//  PetDayCare
//
//  Created by Jai Mehta on 3/26/25.
//

// SignUpView.swift
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct SignUpView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var navigateToLogin = false
    @State private var errorMessage: String?
    @Binding var isAuthenticated: Bool

    var body: some View {
        NavigationStack {
            ZStack {
                // Background Color
                Color(hex: "#AE6427")
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    Spacer()
                    
                    // Header Text
                    Text("Join the Family!")
                        .font(.custom("MarkerFelt-Wide", size: 32))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)

                    // Input Fields
                    CustomTextField(placeholder: "First Name", text: $firstName)
                    CustomTextField(placeholder: "Last Name", text: $lastName)
                    CustomTextField(placeholder: "Email", text: $email)
                    CustomTextField(placeholder: "Phone No.", text: $phone)
                    CustomTextField(placeholder: "Set Password", text: $password, isSecure: true)
                    CustomTextField(placeholder: "Confirm Password", text: $confirmPassword, isSecure: true)

                    // Join Button
                    Button(action: {
                        // Handle sign-up logic here
                        AuthService.shared.signUpUser(email: email, password: password) { result in
                            switch result {
                            case .success(let user):
                                FirestoreService.shared.createUserProfile(email: email, firstName: firstName, lastName: lastName, phone: phone) { success, error in
                                    if success {
                                        isAuthenticated = true  // <-- Update auth state
                                    } else {
                                        errorMessage = "Error saving user profile."
                                    }
                                }
                            case .failure(let error):
                                errorMessage = error.localizedDescription
                            }
                        }
                    }) {
                        Text("Join")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color(hex: "#8C6239"))
                            .frame(width: 150, height: 50)
                            .background(Color(hex: "#F9F3B9"))
                            .cornerRadius(25)
                    }
                    
                    Spacer()
                    
                    // Already have an account? Log In
                    Button(action: {
                        navigateToLogin = true
                    }) {
                        Text("Already have an account? Log In")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(Color(hex: "#F9F3B9"))
                    }
                    .padding(.bottom, 30)
                    
                    NavigationLink("", destination: LoginView(isAuthenticated: $isAuthenticated), isActive: $navigateToLogin)
                }
            }
        }
    }
}

// Custom Text Field for styling consistency
struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    
    var body: some View {
        Group {
            if isSecure {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
            }
        }
        .padding()
        .background(Color(hex: "#F9F3B9").opacity(0.3))
        .cornerRadius(20)
        .foregroundColor(.black)
        .frame(width: 280, height: 50)
        .font(.system(size: 18, weight: .bold))
        .autocapitalization(.none)
    }
}

