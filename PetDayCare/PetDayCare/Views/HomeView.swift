//
//  HomeView.swift
//  PetDayCare
//
//  Created by Jai Mehta on 3/26/25.
//

import SwiftUI
import FirebaseAuth

//struct HomeView: View {
//    @State private var isLoggedIn = Auth.auth().currentUser != nil
//    @State private var userPoints: Int = 100 // Placeholder for points system
//    @State private var showDrawer = false // State for drawer menu
//    @State private var isAuthenticated = false // ✅ Added authentication state
//    @State private var navigateToBeASitter = false
//
//    var body: some View {
//        Group {
//            if isLoggedIn {
//                HomeContentView(userPoints: $userPoints, showDrawer: $showDrawer, navigateToBeASitter: $navigateToBeASitter)
//                    .overlay(
//                        DrawerMenu(isOpen: $showDrawer)
//                    )
//            } else {
//                LoginView(isAuthenticated: $isAuthenticated) // ✅ Pass isAuthenticated binding
//            }
//        }
//        .onAppear {
//            checkAuthStatus()
//        }
//    }
//
//    func checkAuthStatus() {
//        Auth.auth().addStateDidChangeListener { auth, user in
//            if user != nil {
//                isLoggedIn = true
//            } else {
//                isLoggedIn = false
//            }
//        }
//    }
//}
//
//struct HomeContentView: View {
//    @Binding var userPoints: Int
//    @Binding var showDrawer: Bool
//    @Binding var navigateToBeASitter: Bool
//
//    var body: some View {
//        ZStack {
//            // Background Color
//            Color(hex: "#AE6427")
//                .ignoresSafeArea()
//            
//            VStack(spacing: 20) {
//                HStack {
//                    // Profile Placeholder (Triggers Drawer)
//                    Circle()
//                        .fill(Color.gray.opacity(0.3))
//                        .frame(width: 40, height: 40)
//                        .overlay(Text("Profile\nPic").font(.caption).foregroundColor(.white))
//                        .padding(.leading, 20)
//                        .onTapGesture {
//                            withAnimation {
//                                showDrawer.toggle()
//                            }
//                        }
//                    
//                    Spacer()
//                    
//                    // Points Display
//                    Text("\(userPoints)")
//                        .font(.system(size: 24, weight: .bold))
//                        .foregroundColor(.white)
//                        .padding(.trailing, 20)
//                }
//                .frame(maxWidth: .infinity, alignment: .top)
//                .padding(.top, 20)
//                
//                Spacer()
//                
//                // Welcome Text
//                Text("WELCOME\nTO\nPETDAYCARE")
//                    .font(.custom("MarkerFelt-Wide", size: 32))
//                    .foregroundColor(.white)
//                    .multilineTextAlignment(.center)
//                
//                // Drop your pet Button
//                Button(action: {
//                    // Drop Pet action
//                }) {
//                    Text("Drop your pet!")
//                        .font(.system(size: 20, weight: .bold))
//                        .foregroundColor(Color(hex: "#8C6239"))
//                        .frame(width: 220, height: 50)
//                        .background(Color(hex: "#F9F3B9"))
//                        .cornerRadius(25)
//                }
//                
//                // Be a Sitter Button
////                Button(action: {
////                    // Be a sitter action
////                }) {
////                    Text("Be a sitter!")
////                        .font(.system(size: 20, weight: .bold))
////                        .foregroundColor(Color(hex: "#8C6239"))
////                        .frame(width: 220, height: 50)
////                        .background(Color(hex: "#F9F3B9"))
////                        .cornerRadius(25)
////                }
//                Button(action: {
//                    navigateToBeASitter = true // ✅ Trigger navigation
//                }) {
//                    Text("Be a sitter!")
//                        .font(.system(size: 20, weight: .bold))
//                        .foregroundColor(Color(hex: "#8C6239"))
//                        .frame(width: 220, height: 50)
//                        .background(Color(hex: "#F9F3B9"))
//                        .cornerRadius(25)
//                }
//
//                // ✅ NavigationLink to BeASitterView
//                NavigationLink("", destination: BeASitterView(), isActive: $navigateToBeASitter)
//                
//                Spacer()
//            }
//        }
//    }
//}
//
//// Drawer Menu
//struct DrawerMenu: View {
//    @Binding var isOpen: Bool
//    
//    var body: some View {
//        ZStack(alignment: .leading) {
//            if isOpen {
//                Color.black.opacity(0.4)
//                    .edgesIgnoringSafeArea(.all)
//                    .onTapGesture {
//                        withAnimation {
//                            isOpen = false
//                        }
//                    }
//                
//                VStack(alignment: .leading) {
//                    Spacer()
//                    
//                    Button(action: {
//                        do {
//                            try Auth.auth().signOut()
//                            isOpen = false
//                        } catch {
//                            print("Error signing out: \(error.localizedDescription)")
//                        }
//                    }) {
//                        Text("Log Out")
//                            .font(.title2)
//                            .foregroundColor(.white)
//                            .padding()
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                            .background(Color.red)
//                            .cornerRadius(10)
//                            .padding()
//                    }
//                    
//                    Spacer()
//                }
//                .frame(width: 250)
//                .background(Color(hex: "#AE6427"))
//                .transition(.move(edge: .leading))
//            }
//        }
//    }
//}

struct HomeView: View {
    @State private var isLoggedIn = Auth.auth().currentUser != nil
    @State private var userPoints: Int = 100 // Placeholder for points system
    @State private var showDrawer = false // State for drawer menu
    @State private var isAuthenticated = false // ✅ Added authentication state
    @State private var navigateToBeASitter = false // ✅ Added for navigation

    var body: some View {
        Group {
            if isLoggedIn {
                HomeContentView(userPoints: $userPoints, showDrawer: $showDrawer, navigateToBeASitter: $navigateToBeASitter) // ✅ Pass as binding
                    .overlay(
                        DrawerMenu(isOpen: $showDrawer)
                    )
            } else {
                LoginView(isAuthenticated: $isAuthenticated) // ✅ Pass isAuthenticated binding
            }
        }
        .onAppear {
            checkAuthStatus()
        }
    }

    func checkAuthStatus() {
        Auth.auth().addStateDidChangeListener { auth, user in
            if user != nil {
                isLoggedIn = true
            } else {
                isLoggedIn = false
            }
        }
    }
}



// Drawer Menu
struct DrawerMenu: View {
    @Binding var isOpen: Bool

    var body: some View {
        ZStack(alignment: .leading) {
            if isOpen {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            isOpen = false
                        }
                    }

                VStack(alignment: .leading) {
                    Spacer()

                    Button(action: {
                        do {
                            try Auth.auth().signOut()
                            isOpen = false
                        } catch {
                            print("Error signing out: \(error.localizedDescription)")
                        }
                    }) {
                        Text("Log Out")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.red)
                            .cornerRadius(10)
                            .padding()
                    }

                    Spacer()
                }
                .frame(width: 250)
                .background(Color(hex: "#AE6427"))
                .transition(.move(edge: .leading))
            }
        }
    }
}
