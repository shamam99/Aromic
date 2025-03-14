//
//  GenerateChoiceViewMode.swift
//  Aromic
//
//  Created by Yara Alshammari on 10/09/1446 AH.
//


import Foundation
import CloudKit

class ScentSelectionViewModel: ObservableObject {
    @Published var hasAllergy: Bool? = nil
    @Published var selectedAllergySafeScents: Set<String> = []
    @Published var selectedPreferredScents: Set<String> = []
    @Published var recommendedPerfumes: [PerfumeModel] = [] // Holds the final results

    let allergySafeScents: [String] = [
        "Musk",
        "Cinnamon",
        "Lavender",
        "Vanilla",
        "Eucalyptus",
        "Peppermint",
        "Jasmine",
        "Citrus (Lemon, Orange, Bergamot)",
        "Ylang-Ylang",
        "Sandalwood"
    ]
    
     
    let availableScents: [String] = [
        "Musk", "Bergamot", "Sandalwood", "Jasmine", "Patchouli", "Vanilla", "Amber",
        "Rose", "Vetiver", "Lemon", "Cedarwood", "Mandarin Orange", "Lavender", "Iris",
        "Lily of the Valley", "Tonka Bean", "Cedar", "Orange Blossom", "Grapefruit",
        "Oakmoss", "Geranium", "Violet", "Cardamom", "Ylang-Ylang", "Orange",
        "Pink Pepper", "Peach"
    ]

    func updateAllergyStatus(_ status: Bool) {
        hasAllergy = status
        selectedAllergySafeScents.removeAll()
        selectedPreferredScents.removeAll()
    }

    func toggleScent(_ scent: String, isAllergySafe: Bool) {
        if isAllergySafe {
            selectedAllergySafeScents = [scent] // Only 1 allergy allowed
        } else {
            if selectedPreferredScents.contains(scent) {
                selectedPreferredScents.remove(scent)
            } else if selectedPreferredScents.count < 4 {
                selectedPreferredScents.insert(scent)
            }
        }
    }

    func isScentSelected(_ scent: String, isAllergySafe: Bool) -> Bool {
        return isAllergySafe ? selectedAllergySafeScents.contains(scent) : selectedPreferredScents.contains(scent)
    }

    // Fetch perfumes based on user selection
    func searchMatchingPerfumes(completion: @escaping () -> Void) {
        CloudKitManager.shared.fetchRecommendedPerfumes(selectedScents: Array(selectedPreferredScents),
                                                        allergies: Array(selectedAllergySafeScents)) { perfumes in
            DispatchQueue.main.async {
                self.recommendedPerfumes = perfumes // Store top 3 perfumes
                completion()
            }
        }
    }
}
