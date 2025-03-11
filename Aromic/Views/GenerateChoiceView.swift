//
//  GenerateChoiceView.swift
//  Aromic
//
//  Created by Yara Alshammari on 10/09/1446 AH.
//

import SwiftUI

struct ScentSelectionView: View {
    @StateObject private var viewModel = ScentSelectionViewModel()
    
    // Diamond positions for decoration
    let diamondPositions: [(CGFloat, CGFloat)] = [
        (145, -280), (-160, -96), (78, 230), (-190, 150), (40, -30), (120,-160)
    ]
    
    var body: some View {
        ZStack {
            // Background Color
            Color(red: 0.04, green: 0.07, blue: 0.08)
                .ignoresSafeArea()
            
            // Background Diamond Icons
            ForEach(diamondPositions.indices, id: \ .self) { index in
                let position = diamondPositions[index]
                Image("diamond")
                    .resizable()
                    .scaledToFit()
                    .opacity(0.3)
                    .frame(width: 40, height: 100)
                    .offset(x: position.0, y: position.1)
            }
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // Navigation Header
                    HStack {
                        Button(action: {
                            // Handle back action
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                                .font(.title)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    // Title
                    Text("Let's Find Your\nScent")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .padding(.top, 5)
                    
                    // Allergy Question
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
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    // Show Selection Based on User Choice
                    if let hasAllergy = viewModel.hasAllergy {
                        if hasAllergy {
                            // First Selection (Allergy-Safe)
                            Text("Choose Up To 3 Scents")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                                .padding(.top, 10)
                            
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 12) {
                                ForEach(viewModel.allergySafeScents, id: \ .self) { scent in
                                    ScentTag(title: scent, isSelected: viewModel.isScentSelected(scent, isAllergySafe: true)) {
                                        viewModel.toggleScent(scent, isAllergySafe: true)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        // Second Selection (Preferred Scents)
                        Text("Choose Up To 8 Preferred Scents")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                            .padding(.top, 10)
                        
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), spacing: 12)], spacing: 17) {
                            ForEach(viewModel.availableScents, id: \ .self) { scent in
                                ScentTag(title: scent, isSelected: viewModel.isScentSelected(scent, isAllergySafe: false)) {
                                    viewModel.toggleScent(scent, isAllergySafe: false)
                                }
                            }
                        }
                        .padding(.horizontal)
                        
                        // Generate My Choices Button
                        if !viewModel.selectedPreferredScents.isEmpty {
                            HStack {
                                Spacer()
                                Button(action: {
                                    // Handle Generate action
                                }) {
                                    Text("Generate My Choices")
                                        .font(.headline)
                                        .padding()
                                        .frame(width: 350) // Expands to full width
                                        .background(Color(red: 0.145, green: 0.267, blue: 0.255))
                                        .foregroundColor(.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 14))
                                }
                                Spacer()
                            }
                            .padding(.horizontal)
                            .padding(.top, 20)
                        }
                    }
                }
            }
        }
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
                    .background(Color(red: 243/255, green: 218/255, blue: 216/255))
                    .foregroundColor(isSelected ? .white : .black)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
    }
    
}
struct ScentSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ScentSelectionView()
    }
}
