//
//  AuthViewModel.swift
//  Aromic
//
//  Created by Shamam Alkafri on 13/03/2025.
//



import SwiftUI
import AuthenticationServices
import CloudKit

class AuthViewModel: NSObject, ObservableObject {
    @Published var user: UserModel?
    @Published var isAuthenticated: Bool = false {
        didSet {
            UserDefaults.standard.set(isAuthenticated, forKey: "isAuthenticated") // ✅ Store login state
        }
    }
    
    private let database = CKContainer.default().publicCloudDatabase
    // MARK: - Handle Sign in with Apple
    func handleSignInWithApple(credential: ASAuthorizationAppleIDCredential) {
        let userID = credential.user
        let email = credential.email ?? UserDefaults.standard.string(forKey: "email") ?? "Unknown"
        let fullName = "\(credential.fullName?.givenName ?? "") \(credential.fullName?.familyName ?? "")".trimmingCharacters(in: .whitespaces)

        // Store email & full name for future logins
        if credential.email != nil { UserDefaults.standard.set(email, forKey: "email") }
        if !fullName.isEmpty { UserDefaults.standard.set(fullName, forKey: "fullName") }
        
        saveUserToCloudKit(userID: userID, email: email, fullName: fullName)
    }

    // MARK: - Save User to CloudKit
    private func saveUserToCloudKit(userID: String, email: String, fullName: String) {
        let recordID = CKRecord.ID(recordName: userID)
        let record = CKRecord(recordType: "User", recordID: recordID)
        
        record["appleUserID"] = userID as CKRecordValue
        record["email"] = email as CKRecordValue
        record["fullName"] = fullName as CKRecordValue

        database.save(record) { _, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error saving user to CloudKit: \(error.localizedDescription)")
                } else {
                    UserDefaults.standard.set(userID, forKey: "userID")
                    self.isAuthenticated = true // ✅ Set user as authenticated
                    self.fetchUserFromCloudKit(userID: userID)
                }
            }
        }
    }

    // MARK: - Check User Session
    func checkUserSession() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        if let userID = UserDefaults.standard.string(forKey: "userID") {
            appleIDProvider.getCredentialState(forUserID: userID) { state, _ in
                DispatchQueue.main.async {
                    if state == .authorized {
                        self.isAuthenticated = true
                        self.fetchUserFromCloudKit(userID: userID)
                    } else {
                        self.isAuthenticated = false
                    }
                }
            }
        }
    }

    // MARK: - Fetch User from CloudKit
    private func fetchUserFromCloudKit(userID: String) {
        let predicate = NSPredicate(format: "appleUserID == %@", userID)
        let query = CKQuery(recordType: "User", predicate: predicate)

        database.perform(query, inZoneWith: nil) { records, error in
            DispatchQueue.main.async {
                if let record = records?.first {
                    self.user = UserModel(record: record)
                } else {
                    print("User not found in CloudKit.")
                }
            }
        }
    }
}

// ✅ Apple Sign-In Delegates
extension AuthViewModel: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            self.handleSignInWithApple(credential: appleIDCredential)
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Sign in with Apple failed: \(error.localizedDescription)")
    }
}
