//
//  AllergyModel.swift
//  Aromic
//
//  Created by Shamam Alkafri on 13/03/2025.
//


import Foundation
import CloudKit

struct AllergyModel: Identifiable {
    var id: String
    var userID: String
    var allergicScents: [String]
    
    init(record: CKRecord) {
        self.id = record.recordID.recordName
        self.userID = record["userID"] as? String ?? ""
        self.allergicScents = record["allergicScents"] as? [String] ?? []
    }
    
    func toCKRecord() -> CKRecord {
        let record = CKRecord(recordType: "Allergy")
        record["userID"] = userID as CKRecordValue
        record["allergicScents"] = allergicScents as CKRecordValue
        return record
    }
}
