//
//  FirestoreService.swift
//  PetDayCare
//
//  Created by Jai Mehta on 3/26/25.
//


// FirestoreService.swift
//import FirebaseFirestore
//import FirebaseAuth
//
//class FirestoreService {
//    static let shared = FirestoreService()
//    private let db = Firestore.firestore()
//    
//    func createUserProfile(email: String, firstName: String, lastName: String, phone: String, completion: @escaping (Bool, Error?) -> Void) {
//        guard let userId = Auth.auth().currentUser?.uid else { return }
//        let userRef = db.collection("users").document(userId)
//        
//        let userData: [String: Any] = [
//            "email": email,
//            "first_name": firstName,
//            "last_name": lastName,
//            "phone": phone,
//            "uid": userId
//        ]
//        
//        userRef.setData(userData, merge: true) { error in
//            if let error = error {
//                completion(false, error)
//            } else {
//                completion(true, nil)
//            }
//        }
//    }
//    
//    func getUserProfile(completion: @escaping ([String: Any]?, Error?) -> Void) {
//        guard let userId = Auth.auth().currentUser?.uid else { return }
//        let userRef = db.collection("users").document(userId)
//        
//        userRef.getDocument { document, error in
//            if let error = error {
//                completion(nil, error)
//            } else {
//                completion(document?.data(), nil)
//            }
//        }
//    }
//}


import FirebaseFirestore
import FirebaseAuth

class FirestoreService {
    static let shared = FirestoreService()
    private let db = Firestore.firestore()
    
    func createUserProfile(email: String, firstName: String, lastName: String, phone: String, completion: @escaping (Bool, Error?) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let userRef = db.collection("users").document(userId)
        
        let userData: [String: Any] = [
            "email": email,
            "first_name": firstName,
            "last_name": lastName,
            "phone": phone,
            "uid": userId
        ]
        
        userRef.setData(userData, merge: true) { error in
            if let error = error {
                completion(false, error)
            } else {
                completion(true, nil)
            }
        }
    }
    
    // ✅ Function to update user availability
    func updateUserAvailability(availableDates: [String: Bool], alwaysAvailable: Bool, completion: @escaping (Bool, Error?) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let userRef = db.collection("users").document(userId)
        
        let availabilityData: [String: Any] = [
            "alwaysAvailable": alwaysAvailable,
            "availableDates": availableDates
        ]
        
        userRef.setData(availabilityData, merge: true) { error in
            if let error = error {
                completion(false, error)
            } else {
                completion(true, nil)
            }
        }
    }
    
    func getUserProfile(completion: @escaping ([String: Any]?, Error?) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let userRef = db.collection("users").document(userId)

        userRef.getDocument { document, error in
            if let error = error {
                completion(nil, error)
            } else {
                completion(document?.data(), nil)
            }
        }
    }
    
    // ✅ Function to get user availability
    func getUserAvailability(completion: @escaping ([String: Bool]?, Bool?, Error?) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let userRef = db.collection("users").document(userId)
        
        userRef.getDocument { document, error in
            if let error = error {
                completion(nil, nil, error)
            } else {
                let data = document?.data()
                let alwaysAvailable = data?["alwaysAvailable"] as? Bool ?? false
                let availableDates = data?["availableDates"] as? [String: Bool] ?? [:]
                completion(availableDates, alwaysAvailable, nil)
            }
        }
    }
}
