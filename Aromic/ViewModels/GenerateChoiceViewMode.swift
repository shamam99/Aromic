//
//  GenerateChoiceViewMode.swift
//  Aromic
//
//  Created by Yara Alshammari on 10/09/1446 AH.
//

import SwiftUI

class ScentSelectionViewModel: ObservableObject {
    @Published var hasAllergy: Bool? = nil
    @Published var selectedAllergySafeScents: Set<String> = []
    @Published var selectedPreferredScents: Set<String> = []

    let allergySafeScents: [String] = ["Alcohol", "Amber", "Bakhoor", "Citrus", "Musk",
                                       "Oud", "Spicy", "Sweet", "Vanilla"]
     
    let availableScents: [String] = [ "Amber", "Aromatic", "Chypre", "Citrus", "Floral", "Fruity", "Herbaceous", "Leather", "Musk", "Spicy", "Woody"]

    func updateAllergyStatus(_ status: Bool) {
        hasAllergy = status
        selectedAllergySafeScents.removeAll()
        selectedPreferredScents.removeAll()
    }

    func toggleScent(_ scent: String, isAllergySafe: Bool) {
        if isAllergySafe {
            if selectedAllergySafeScents.contains(scent) {
                selectedAllergySafeScents.remove(scent)
            } else if selectedAllergySafeScents.count < 3 {
                selectedAllergySafeScents.insert(scent)
            }
        } else {
            if selectedPreferredScents.contains(scent) {
                selectedPreferredScents.remove(scent)
            } else if selectedPreferredScents.count < 8 {
                selectedPreferredScents.insert(scent)
            }
        }
    }

    func isScentSelected(_ scent: String, isAllergySafe: Bool) -> Bool {
        return isAllergySafe ? selectedAllergySafeScents.contains(scent) : selectedPreferredScents.contains(scent)
    }
}
