//
//  PetDayCareApp.swift
//  PetDayCare
//
//  Created by Jai Mehta on 3/26/25.
//

import SwiftUI
import FirebaseCore


@main
struct PetDayCareApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
