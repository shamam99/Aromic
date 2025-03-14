//
//  UserModel.swift
//  Aromic
//
//  Created by Shamam Alkafri on 13/03/2025.
//


import CloudKit

struct UserModel {
    var id: CKRecord.ID
    var fullName: String
    var email: String
    var gender: String?
    var birthday: String?
    var phone: String?
    var profileImage: CKAsset? 

    init(record: CKRecord) {
        self.id = record.recordID
        self.fullName = record["fullName"] as? String ?? "Unknown User"
        self.email = record["email"] as? String ?? "No Email"
        self.gender = record["gender"] as? String
        self.birthday = record["birthday"] as? String
        self.phone = record["phone"] as? String
        self.profileImage = record["profileImage"] as? CKAsset
    }

    //  Convert Model to CKRecord
    func toCKRecord() -> CKRecord {
        let record = CKRecord(recordType: "User", recordID: id)
        record["fullName"] = fullName as CKRecordValue
        record["email"] = email as CKRecordValue
        record["gender"] = gender as CKRecordValue?
        record["birthday"] = birthday as CKRecordValue?
        record["phone"] = phone as CKRecordValue?
        record["profileImage"] = profileImage
        return record
    }
}
