//
//  HomeContentView.swift
//  PetDayCare
//
//  Created by Jai Mehta on 3/30/25.
//

import SwiftUI

struct HomeContentView: View {
    @Binding var userPoints: Int
    @Binding var showDrawer: Bool
    @Binding var navigateToBeASitter: Bool // ✅ Added binding for navigation

    var body: some View {
        ZStack {
            // Background Color
            Color(hex: "#AE6427")
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                HStack {
                    // Profile Placeholder (Triggers Drawer)
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 40, height: 40)
                        .overlay(Text("Profile\nPic").font(.caption).foregroundColor(.white))
                        .padding(.leading, 20)
                        .onTapGesture {
                            withAnimation {
                                showDrawer.toggle()
                            }
                        }
                    
                    Spacer()
                    
                    // Points Display
                    Text("\(userPoints)")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.trailing, 20)
                }
                .frame(maxWidth: .infinity, alignment: .top)
                .padding(.top, 20)
                
                Spacer()
                
                // Welcome Text
                Text("WELCOME\nTO\nPETDAYCARE")
                    .font(.custom("MarkerFelt-Wide", size: 32))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                // Drop your pet Button
                Button(action: {
                    // Drop Pet action
                }) {
                    Text("Drop your pet!")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color(hex: "#8C6239"))
                        .frame(width: 220, height: 50)
                        .background(Color(hex: "#F9F3B9"))
                        .cornerRadius(25)
                }
                
                // ✅ Be a Sitter Button
                Button(action: {
                    navigateToBeASitter = true // ✅ Modify the binding
                }) {
                    Text("Be a sitter!")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color(hex: "#8C6239"))
                        .frame(width: 220, height: 50)
                        .background(Color(hex: "#F9F3B9"))
                        .cornerRadius(25)
                }

                // ✅ NavigationLink to BeASitterView
                NavigationLink("", destination: BeASitterView(), isActive: $navigateToBeASitter)

                Spacer()
            }
        }
    }
}
