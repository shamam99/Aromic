//
//  ProfileViewModel.swift
//  Aromic
//
//  Created by Shamam Alkafri on 13/03/2025.
//

import SwiftUI
import CloudKit

class ProfileViewModel: ObservableObject {
    @Published var user: UserModel?
    @Published var selectedImage: UIImage?
    @Published var isEditing = false

    private let database = CKContainer.default().publicCloudDatabase
    private var userRecordID: CKRecord.ID?

    init() {
        fetchUserData()
    }

    // ✅ Fetch User Data and Set Record ID
    func fetchUserData() {
        guard let userID = UserDefaults.standard.string(forKey: "userID") else { return }
        let predicate = NSPredicate(format: "appleUserID == %@", userID)
        let query = CKQuery(recordType: "User", predicate: predicate)

        database.perform(query, inZoneWith: nil) { records, error in
            DispatchQueue.main.async {
                if let record = records?.first {
                    self.userRecordID = record.recordID
                    self.user = UserModel(record: record)
                    self.loadProfileImage(from: record)
                } else {
                    print("User not found in CloudKit.")
                }
            }
        }
    }

    // ✅ Load Profile Image from CloudKit
    private func loadProfileImage(from record: CKRecord) {
        if let asset = record["profileImage"] as? CKAsset, let fileURL = asset.fileURL {
            if let imageData = try? Data(contentsOf: fileURL), let uiImage = UIImage(data: imageData) {
                self.selectedImage = uiImage
            }
        }
    }

    // ✅ Save Updated Profile Data (Fix CloudKit Overwrite Issue)
    func saveProfileData() {
        guard let user = user, let recordID = userRecordID else { return }

        database.fetch(withRecordID: recordID) { fetchedRecord, error in
            DispatchQueue.main.async {
                if let fetchedRecord = fetchedRecord {
                    fetchedRecord["gender"] = user.gender as CKRecordValue?
                    fetchedRecord["birthday"] = user.birthday as CKRecordValue?
                    fetchedRecord["phone"] = user.phone as CKRecordValue?

                    if let selectedImage = self.selectedImage {
                        fetchedRecord["profileImage"] = self.saveImageToCloudKit(selectedImage)
                    }

                    self.database.save(fetchedRecord) { _, error in
                        DispatchQueue.main.async {
                            if let error = error {
                                print("Error updating user data: \(error.localizedDescription)")
                            } else {
                                print("User profile updated successfully")
                                self.fetchUserData() // Reload Data After Save
                            }
                        }
                    }
                } else {
                    print("Error fetching user record: \(error?.localizedDescription ?? "Unknown error")")
                }
            }
        }
    }

    // ✅ Convert UIImage to CKAsset for CloudKit Storage
    private func saveImageToCloudKit(_ image: UIImage) -> CKAsset? {
        let tempDirectory = FileManager.default.temporaryDirectory
        let fileURL = tempDirectory.appendingPathComponent("\(UUID().uuidString).jpg")

        if let imageData = image.jpegData(compressionQuality: 0.8) {
            do {
                try imageData.write(to: fileURL)
                return CKAsset(fileURL: fileURL)
            } catch {
                print("Error saving image to local storage: \(error)")
            }
        }
        return nil
    }
}
