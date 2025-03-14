//
//  PerfumeRecommendationView.swift
//  Aromic
//
//  Created by Shamam Alkafri on 12/03/2025.
//


import SwiftUI

struct PerfumeRecommendationView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var currentIndex = 0
    @State private var isFavorite: Bool = false
    @State private var favoritePerfumes: [PerfumeModel] = []
    var perfumes: [PerfumeModel] = []

    var body: some View {
        ZStack {
            // Background Image
            Image("back")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("X")
                            .font(.custom("SF Pro Display", size: 32).weight(.bold))
                            .foregroundColor(Color.white)
                    }
                    .padding(.leading, 25)
                    .padding(.vertical, 40)

                    Spacer()

                    // Favorite Button  Positioned correctly
                    Button(action: {
                        toggleFavorite()
                    }) {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .resizable()
                            .frame(width: 23, height: 23)
                            .foregroundColor(isFavorite ? Color(red: 81/255, green: 28/255, blue: 41/255) : .white)
                    }
                    .padding(.trailing, 40)
                    .padding(.top, 35)
                }
                .padding(.top, 25)

                // Title
                Text("Your New Scents\nAre ..")
                    .font(.custom("SF Pro Display", size: 25).weight(.heavy))
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 25)
                    .padding(.top, -40)

                Spacer()

                // Perfume Image Section Fixed image used for now
                ZStack {
                    Image("Aromic")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 350)
                        .padding(.top, 40)


//                    Image("Aromic")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 300, height: 350)
//                        .padding(.top, -20)
                }
//                .frame(maxWidth: .infinity)

                Spacer()

                // Left & Right Navigation Arrows
                HStack {
                    Button(action: {
                        if currentIndex > 0 {
                            currentIndex -= 1
                            updateFavoriteStatus()
                        }
                    }) {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                    }
                    .padding(.leading, 20)
                    .disabled(currentIndex == 0)

                    Spacer()

                    Button(action: {
                        if currentIndex < perfumes.count - 1 {
                            currentIndex += 1
                            updateFavoriteStatus()
                        }
                    }) {
                        Image(systemName: "chevron.right")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                    }
                    .padding(.trailing, 20)
                    .disabled(currentIndex == perfumes.count - 1)
                }
                .padding(.top, -180)

                // Perfume Details Card
                ZStack(alignment: .topLeading) {
                    Image("Rectangle")
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width, height: 350)
                        .clipped()

                    VStack(alignment: .leading, spacing: 15) {
                        if !perfumes.isEmpty {
                            DetailRow(title: "Name", value: perfumes[currentIndex].name)
                            DetailRow(title: "Brand", value: perfumes[currentIndex].brand)
                            DetailRow(title: "Season", value: perfumes[currentIndex].season)
                            DetailRow(title: "Kind", value: perfumes[currentIndex].isMale ? "Male Scent" : "Female Scent")
                        } else {
                            Text("No perfume matches found.")
                                .font(.custom("SF Pro Display", size: 20))
                                .foregroundColor(Color.white)
                                .padding(.top, 100)
                        }
                    }
                    .padding(.leading, 30)
                    .padding(.top, 90)
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom, -2)
            }
            .padding(.top, 10)
        }
        .onAppear {
            loadFavorites()
            updateFavoriteStatus()
        }
        .navigationBarHidden(true)
    }

    // Toggle Favorite Function
    private func toggleFavorite() {
        guard !perfumes.isEmpty else { return }
        let perfume = perfumes[currentIndex]

        if isFavorite {
            CloudKitManager.shared.removeFavoritePerfume(perfumeName: perfume.name) { success in
                if success {
                    isFavorite = false
                    favoritePerfumes.removeAll { $0.id == perfume.id }
                }
            }
        } else {
            CloudKitManager.shared.addFavoritePerfume(userID: UserDefaults.standard.string(forKey: "userID") ?? "", perfume: perfume) { success in
                if success {
                    isFavorite = true
                    favoritePerfumes.append(perfume)
                }
            }
        }
    }

    //  Load Favorites
    private func loadFavorites() {
        CloudKitManager.shared.fetchFavoritePerfumes(userID: UserDefaults.standard.string(forKey: "userID") ?? "") { perfumes in
            self.favoritePerfumes = perfumes
            updateFavoriteStatus()
        }
    }

    //  Update Favorite Status Based on Current Perfume
    private func updateFavoriteStatus() {
        guard !perfumes.isEmpty else { return }
        let currentPerfume = perfumes[currentIndex]
        isFavorite = favoritePerfumes.contains(where: { $0.id == currentPerfume.id })
    }
}

// Detail Row Component
struct DetailRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Image("star")
                .resizable()
                .frame(width: 20, height: 20)
                .padding(.trailing, 8)
            
            Text("\(title) :")
                .font(.custom("SF Pro Display", size: 23).weight(.heavy))
                .foregroundColor(Color(hex: "#0B1215"))
            
            Text(value)
                .font(.custom("SF Pro Display", size: 20))
                .foregroundColor(Color(hex: "#0B1215"))
        }
    }
}



// Hex Color Extension
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var hexNumber: UInt64 = 0
        if scanner.scanHexInt64(&hexNumber) {
            let r = Double((hexNumber & 0xff0000) >> 16) / 255.0
            let g = Double((hexNumber & 0x00ff00) >> 8) / 255.0
            let b = Double(hexNumber & 0x0000ff) / 255.0
            self.init(red: r, green: g, blue: b)
        } else {
            self.init(red: 0, green: 0, blue: 0)
        }
    }
}

#Preview {
    PerfumeRecommendationView()
}

