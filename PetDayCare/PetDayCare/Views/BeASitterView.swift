//
//  BeASitterView.swift
//  PetDayCare
//
//  Created by Jai Mehta on 3/30/25.
//

import SwiftUI

struct BeASitterView: View {
    @State private var alwaysAvailable = false
    @State private var availableDates: [String: Bool] = [:]
    @State private var showSavePrompt = false
    @State private var showDrawer = false
    @State private var userPoints = 100
    @State private var hasUnsavedChanges = false
    
    let daysInMonth = 31 // Placeholder for now, can adjust dynamically
    
    var body: some View {
        ZStack {
            Color(hex: "#AE6427").ignoresSafeArea()
            
            VStack {
                // ✅ Top Section: Profile & Points
                HStack {
                    // Profile Pic (Opens Drawer)
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 40, height: 40)
                        .overlay(Text("Profile\nPic").font(.caption).foregroundColor(.white))
                        .padding(.leading, 20)
                        .onTapGesture {
                            withAnimation { showDrawer.toggle() }
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
                
                // ✅ "Always Available" Toggle
                HStack {
                    Text("Always Available")
                        .font(.custom("MarkerFelt-Wide", size: 24))
                        .foregroundColor(.white)
                    Toggle("", isOn: $alwaysAvailable)
                        .onChange(of: alwaysAvailable) { newValue in
                            if newValue {
                                for i in 1...daysInMonth {
                                    availableDates[String(i)] = true
                                }
                            }
                            hasUnsavedChanges = true
                        }
                }
                
                Text("Choose Dates")
                    .font(.custom("MarkerFelt-Wide", size: 20))
                    .foregroundColor(.white)
                
                // ✅ Calendar Grid
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(hex: "#F9F3B9"))
                    .frame(width: 300, height: 250)
                    .overlay(
                        VStack {
                            Text("Calendar")
                                .font(.custom("MarkerFelt-Wide", size: 18))
                                .foregroundColor(Color(hex: "#8C6239"))
                            
                            // Grid of Dates
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                                ForEach(1...daysInMonth, id: \.self) { day in
                                    Toggle("", isOn: Binding(
                                        get: { availableDates[String(day), default: false] },
                                        set: { availableDates[String(day)] = $0; hasUnsavedChanges = true }
                                    ))
                                    .labelsHidden()
                                }
                            }
                        }
                    )
                
                // ✅ Save Button
                Button(action: {
                    saveAvailability()
                }) {
                    Text("Save")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color(hex: "#8C6239"))
                        .frame(width: 150, height: 50)
                        .background(Color(hex: "#F9F3B9"))
                        .cornerRadius(25)
                }
                .padding(.top, 10)
                
                Spacer()
            }
            
            // ✅ Drawer Overlay
            DrawerMenu(isOpen: $showDrawer)
        }
        .onAppear {
            loadAvailability()
        }
        .onDisappear {
            if hasUnsavedChanges {
                showSavePrompt = true
            }
        }
        .alert("Unsaved Changes", isPresented: $showSavePrompt, actions: {
            Button("Save", role: .none) { saveAvailability() }
            Button("Discard", role: .cancel) {}
        }, message: {
            Text("You have unsaved changes. Would you like to save before exiting?")
        })
    }
    
    private func saveAvailability() {
        FirestoreService.shared.updateUserAvailability(availableDates: availableDates, alwaysAvailable: alwaysAvailable) { success, error in
            if success {
                hasUnsavedChanges = false
            }
        }
    }
    
    private func loadAvailability() {
        FirestoreService.shared.getUserAvailability { dates, alwaysAvailable, error in
            if let dates = dates, let alwaysAvailable = alwaysAvailable {
                self.availableDates = dates
                self.alwaysAvailable = alwaysAvailable
            }
        }
    }
}
