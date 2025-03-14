//
//  PerfumeModel.swift
//  Aromic
//
//  Created by Shamam Alkafri on 13/03/2025.
//


import Foundation
import CloudKit

struct PerfumeModel: Identifiable {
    var id: CKRecord.ID
    var name: String
    var brand: String
    var season: String
    var isMale: Bool
    var topNotes: [String]
    var heartNotes: [String]
    var baseNotes: [String]

    init(record: CKRecord) {
        self.id = record.recordID
        self.name = (record["Perfume_Name"] as? String ?? "Unknown Perfume").replacingOccurrences(of: "_", with: " ")
        self.brand = (record["Brand"] as? String ?? "Unknown Brand").replacingOccurrences(of: "_", with: " ")
        self.season = (record["Seasonal_Preference"] as? String ?? "All Seasons").replacingOccurrences(of: "_", with: " ")
        self.isMale = (record["isMale"] as? Int ?? 1) == 1  
        self.topNotes = record["Top_Notes"] as? [String] ?? []
        self.heartNotes = record["Heart_Notes"] as? [String] ?? []
        self.baseNotes = record["Base_Notes"] as? [String] ?? []
    }
}
