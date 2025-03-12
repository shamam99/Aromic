//
//  PerfumeRecoView.swift
//  Aromic
//
//  Created by Shamam Alkafri on 12/03/2025.
//

//import SwiftUI
//import CoreML
//
//struct PerfumeRecoView: View {
//    @State private var selectedSeason: String = ""
//    @State private var selectedOccasion: String = ""
//    @State private var selectedAgeGroup: String = ""
//    @State private var selectedPersonality: String = ""
//    @State private var selectedBudget: String = ""
//    @State private var selectedBrand: String = ""
//    @State private var selectedOccasionDaily: Bool = false
//    @State private var selectedOccasionEvening: Bool = false
//    @State private var selectedOccasionWork: Bool = false
//    @State private var selectedOccasionSpecial: Bool = false
//    @State private var selectedSeasonSpring: Bool = false
//    @State private var selectedSeasonSummer: Bool = false
//    @State private var selectedSeasonAutumn: Bool = false
//    @State private var selectedSeasonWinter: Bool = false
//    @State private var recommendedPerfume: String = ""
//
//    let seasons = ["Spring", "Summer", "Fall", "Winter"]
//    let occasions = ["Casual", "Work", "Evening", "Sports", "Romantic"]
//    let ageGroups = ["Teen", "Young Adult", "Adult", "Senior"]
//    let personalities = ["Elegant", "Bold", "Playful", "Mysterious", "Fresh"]
//    let budgets = ["Low", "Medium", "High", "Luxury"]
//    let brands = ["Dior", "Chanel", "Gucci", "YSL", "Armani"]
//
//    var body: some View {
//        ZStack {
//            Image("BG")
//                .resizable()
//                .scaledToFill()
//                .ignoresSafeArea()
//            
//            VStack(alignment: .leading, spacing: 20) {
//                Button(action: { /* Handle back action */ }) {
//                    Image(systemName: "chevron.left")
//                        .font(.system(size: 32, weight: .bold))
//                        .foregroundColor(.white)
//                }
//                .padding(.leading, 25)
//                .padding(.top, 10)
//                
//                Text("Find Your Perfect Perfume")
//                    .font(.custom("SF Pro Display", size: 30).weight(.bold))
//                    .foregroundColor(.white)
//                    .multilineTextAlignment(.leading)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(.leading, 25)
//                    
//                // Dropdown selections
//                Group {
//                    DropdownPicker(title: "Select Season", options: seasons, selection: $selectedSeason)
//                    DropdownPicker(title: "Select Occasion", options: occasions, selection: $selectedOccasion)
//                    DropdownPicker(title: "Select Age Group", options: ageGroups, selection: $selectedAgeGroup)
//                    DropdownPicker(title: "Select Personality", options: personalities, selection: $selectedPersonality)
//                    DropdownPicker(title: "Select Budget", options: budgets, selection: $selectedBudget)
//                    DropdownPicker(title: "Select Preferred Brand", options: brands, selection: $selectedBrand)
//                    
//                    // Occasion Preferences
//                    Toggle("Daily Use", isOn: $selectedOccasionDaily)
//                        .toggleStyle(SwitchToggleStyle(tint: .green))
//                    Toggle("Evening", isOn: $selectedOccasionEvening)
//                        .toggleStyle(SwitchToggleStyle(tint: .green))
//                    Toggle("Work", isOn: $selectedOccasionWork)
//                        .toggleStyle(SwitchToggleStyle(tint: .green))
//                    Toggle("Special Events", isOn: $selectedOccasionSpecial)
//                        .toggleStyle(SwitchToggleStyle(tint: .green))
//
//                    // Seasonal Preferences
//                    Toggle("Spring", isOn: $selectedSeasonSpring)
//                        .toggleStyle(SwitchToggleStyle(tint: .blue))
//                    Toggle("Summer", isOn: $selectedSeasonSummer)
//                        .toggleStyle(SwitchToggleStyle(tint: .blue))
//                    Toggle("Autumn", isOn: $selectedSeasonAutumn)
//                        .toggleStyle(SwitchToggleStyle(tint: .blue))
//                    Toggle("Winter", isOn: $selectedSeasonWinter)
//                        .toggleStyle(SwitchToggleStyle(tint: .blue))
//                }
//                .padding(.horizontal, 25)
//                
//                Button(action: {
//                    recommendPerfume()
//                }) {
//                    Text("Generate My Perfume")
//                        .font(.custom("SF Pro Display", size: 18).weight(.bold))
//                        .foregroundColor(.white)
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .background(Color.green)
//                        .cornerRadius(15)
//                }
//                .padding(.horizontal, 25)
//                .padding(.top, 20)
//                
//                if !recommendedPerfume.isEmpty {
//                    Text("Recommended Perfume: \(recommendedPerfume)")
//                        .font(.custom("SF Pro Display", size: 20).weight(.bold))
//                        .foregroundColor(.white)
//                        .padding()
//                        .background(Color.black.opacity(0.7))
//                        .cornerRadius(15)
//                        .padding(.horizontal, 25)
//                }
//                
//                Spacer()
//            }
//        }
//        .navigationBarHidden(true)
//    }
//    
//    func recommendPerfume() {
//        do {
//            let config = MLModelConfiguration()
//            let model = try perfumePredection(configuration: config)
//            
//            // Convert String Budget to Int64
//            let budgetValue: Int64 = convertBudgetToInt(selectedBudget)
//
//            // Convert Bool values to numeric values (0 = False, 1 = True)
//            let input = try perfumePredectionInput(
//                season: selectedSeason,
//                occasion: selectedOccasion,
//                age_group: selectedAgeGroup,
//                personality: selectedPersonality,
//                Budget: budgetValue,
//                Brand: selectedBrand,
//                Occasion_Daily_Use: selectedOccasionDaily ? 1 : 0,
//                Occasion_Evening: selectedOccasionEvening ? 1 : 0,
//                Occasion_Work: selectedOccasionWork ? 1 : 0,
//                Occasion_Special_Events: selectedOccasionSpecial ? 1 : 0,
//                Seasonal_Preference_Spring: selectedSeasonSpring ? 1 : 0,
//                Seasonal_Preference_Summer: selectedSeasonSummer ? 1 : 0,
//                Seasonal_Preference_Autumn: selectedSeasonAutumn ? 1 : 0,
//                Seasonal_Preference_Winter: selectedSeasonWinter ? 1 : 0
//            )
//
//            let output = try model.prediction(input: input)
//            self.recommendedPerfume = output.perfume_name
//        } catch {
//            print("Error running model: \(error)")
//        }
//    }
//
//    func convertBudgetToInt(_ budget: String) -> Int64 {
//        switch budget {
//        case "Low": return 0
//        case "Medium": return 1
//        case "High": return 2
//        case "Luxury": return 3
//        default: return 0
//        }
//    }
//}
//
//struct DropdownPicker: View {
//    let title: String
//    let options: [String]
//    @Binding var selection: String
//    
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text(title)
//                .font(.custom("SF Pro Display", size: 18).weight(.bold))
//                .foregroundColor(.white)
//            
//            Picker(title, selection: $selection) {
//                ForEach(options, id: \.self) { option in
//                    Text(option).tag(option)
//                }
//            }
//            .pickerStyle(MenuPickerStyle())
//            .frame(maxWidth: .infinity)
//            .padding()
//            .background(Color.white.opacity(0.2))
//            .cornerRadius(10)
//        }
//    }
//}
//
//#Preview {
//    PerfumeRecoView()
//}
