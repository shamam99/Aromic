//
//  CloudKitManager.swift
//  Aromic
//
//  Created by Shamam Alkafri on 13/03/2025.
//

import CloudKit
import SwiftUI

class CloudKitManager {
    static let shared = CloudKitManager()
    private let container = CKContainer.default()
    let database = CKContainer.default().publicCloudDatabase
    
    // MARK: - Fetch User Data
    func fetchUserData(completion: @escaping (UserModel?) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "User", predicate: predicate)
        
        database.perform(query, inZoneWith: nil) { records, error in
            guard let record = records?.first, error == nil else {
                print("Error fetching user: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }
            
            let user = UserModel(record: record)
            
            DispatchQueue.main.async {
                completion(user)
            }
        }
    }
    
    // MARK: - Fetch Perfumes Based on Preferences
    func fetchRecommendedPerfumes(selectedScents: [String], allergies: [String], completion: @escaping ([PerfumeModel]) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Perfume", predicate: predicate)
        
        database.perform(query, inZoneWith: nil) { records, error in
            guard let records = records, error == nil else {
                print("Error fetching perfumes: \(error?.localizedDescription ?? "Unknown error")")
                completion([])
                return
            }
            
            let perfumes = records.compactMap { record -> PerfumeModel? in
                let perfume = PerfumeModel(record: record)
                let allNotes = perfume.topNotes + perfume.heartNotes + perfume.baseNotes

                // Ensure at least 2 matches with selected scents
                let matchCount = selectedScents.filter(allNotes.contains).count
                if matchCount < 2 {
                    return nil
                }

                // Exclude perfumes containing allergy notes
                if !allergies.isEmpty && allergies.contains(where: allNotes.contains) {
                    return nil
                }
                
                return perfume
            }

            // Return top 3 perfumes based on matches
            DispatchQueue.main.async {
                completion(Array(perfumes.prefix(3)))
            }
        }
    }

    
    // MARK: - Manage Favorites
    func addFavoritePerfume(userID: String, perfume: PerfumeModel, completion: @escaping (Bool) -> Void) {
        let record = CKRecord(recordType: "Favorite")
        record["appleUserID"] = userID as CKRecordValue
        record["Perfume_Name"] = perfume.name as CKRecordValue
        record["Brand"] = perfume.brand as CKRecordValue

        database.save(record) { _, error in
            DispatchQueue.main.async {
                completion(error == nil)
            }
        }
    }
    
    func fetchFavoritePerfumes(userID: String, completion: @escaping ([PerfumeModel]) -> Void) {
        let predicate = NSPredicate(format: "appleUserID == %@", userID)
        let query = CKQuery(recordType: "Favorite", predicate: predicate)

        database.perform(query, inZoneWith: nil) { records, error in
            DispatchQueue.main.async {
                let perfumes = records?.compactMap { PerfumeModel(record: $0) } ?? []
                completion(perfumes)
            }
        }
    }

    
    func removeFavoritePerfume(perfumeName: String, completion: @escaping (Bool) -> Void) {
        let predicate = NSPredicate(format: "Perfume_Name == %@", perfumeName)
        let query = CKQuery(recordType: "Favorite", predicate: predicate)
        
        database.perform(query, inZoneWith: nil) { records, error in
            guard let record = records?.first, error == nil else {
                DispatchQueue.main.async {
                    completion(false)
                }
                return
            }
            
            self.database.delete(withRecordID: record.recordID) { _, error in
                DispatchQueue.main.async {
                    completion(error == nil)
                }
            }
        }
    }
}
