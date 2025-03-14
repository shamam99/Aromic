//
//  GenerateChoiceView.swift
//  Aromic
//
//  Created by Yara Alshammari on 10/09/1446 AH.
//



import SwiftUI

struct ScentSelectionView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = ScentSelectionViewModel()
    @State private var navigateToResults = false

    var body: some View {
        ZStack {
            Color(red: 0.04, green: 0.07, blue: 0.08)
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Back Button
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .padding(.leading, 10)
                        .padding(.top, 10)

                        Spacer()
                    }
                    .padding(.top, -10)

                    // Title
                    Text("Let's Find Your\nScent")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .padding(.top, 5)

                    // Allergy Selection
                    Text("Do You Have A Certain\nAllergies?")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal)

                    HStack {
                        ToggleButton(title: "Yes", isSelected: viewModel.hasAllergy == true) {
                            viewModel.updateAllergyStatus(true)
                        }
                        ToggleButton(title: "No", isSelected: viewModel.hasAllergy == false) {
                            viewModel.updateAllergyStatus(false)
                        }
                    }
                    .padding(.horizontal, 5)
                    .padding(.top, 10)

                    // If allergy is selected
                    if let hasAllergy = viewModel.hasAllergy, hasAllergy {
                        Text("Select 1 Allergy")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                            .padding(.top, 10)

                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 12) {
                            ForEach(viewModel.allergySafeScents, id: \.self) { scent in
                                ScentTag(title: scent, isSelected: viewModel.isScentSelected(scent, isAllergySafe: true)) {
                                    viewModel.toggleScent(scent, isAllergySafe: true)
                                }
                            }
                        }
                        .padding(.leading, 2)
                    }

                    // Preferred Scent Selection
                    Text("Choose 3 to 4 Preferred Scents")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal,17)
                        .padding(.top, 10)

                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), spacing: 12)], spacing: 17) {
                        ForEach(viewModel.availableScents, id: \.self) { scent in
                            ScentTag(title: scent, isSelected: viewModel.isScentSelected(scent, isAllergySafe: false)) {
                                viewModel.toggleScent(scent, isAllergySafe: false)
                            }
                        }
                    }
                    .padding(.leading, 1)

                    // Generate Choices Button
                    if viewModel.selectedPreferredScents.count >= 3 {
                        Button(action: {
                            viewModel.searchMatchingPerfumes {
                                navigateToResults = true
                            }
                        }) {
                            Text("Generate My Choices")
                                .font(.headline)
                                .padding()
                                .frame(width: 350)
                                .background(Color(red: 0.145, green: 0.267, blue: 0.255))
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 14))
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                    }
                }
                .padding(.leading, 10)
            }
        }
        
        .navigationDestination(isPresented: $navigateToResults) {
            PerfumeRecommendationView(perfumes: viewModel.recommendedPerfumes)
        }
        .navigationBarHidden(true)
    }



    
    // Custom Toggle Button
    struct ToggleButton: View {
        let title: String
        let isSelected: Bool
        let action: () -> Void
        
        var body: some View {
            Button(action: action) {
                HStack {
                    Image(systemName: isSelected ? "checkmark.square.fill" : "square")
                        .foregroundColor(.white)
                    Text(title)
                        .foregroundColor(.white)
                }
                .padding()
            }
        }
    }
    
    // Scent Tag Button
    struct ScentTag: View {
        let title: String
        let isSelected: Bool
        let action: () -> Void
        
        var body: some View {
            Button(action: action) {
                Text(title)
                    .font(.headline)
                    .padding()
                    .background(isSelected ? Color.blue : Color(red: 243/255, green: 218/255, blue: 216/255))
                    .foregroundColor(isSelected ? .white : .black)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
    }
}

#Preview {
    ScentSelectionView()
}
