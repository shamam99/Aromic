//
//  FavoritesView.swift
//  Aromic
//
//  Created by Shamam Alkafri on 12/03/2025.
//


import SwiftUI

struct FavoritesView: View {
    @State private var favoritePerfumes: [FavoritePerfume] = [
        FavoritePerfume(name: "BURBERRY HER", imageName: "burberry"),
        FavoritePerfume(name: "GRIS DIOR", imageName: "gris_dior"),
        FavoritePerfume(name: "GIORGIO ARMANI SI", imageName: "giorgio_armani"),
        FavoritePerfume(name: "CHANEL N5", imageName: "chanel_n5")
    ]
    
    var body: some View {
        ZStack {
            // Background Image
            Image("BG")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Button(action: {
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .padding(.leading, 25)
                    .padding(.top, 10)

                    Spacer()
                }
                .padding(.top, 80)

                // Title
                Text("Check Out Your\nFavorites Here")
                    .font(.custom("SF Pro Display", size: 30).weight(.heavy))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 25)
                    .padding(.top, 20)
                
                // Scrollable Grid of Favorite Perfumes
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 2), spacing: 20) {
                        ForEach(favoritePerfumes, id: \.name) { perfume in
                            FavoritePerfumeCard(perfume: perfume, removeAction: {
                                removeFromFavorites(perfume: perfume)
                            })
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                }
            }
        }
        .navigationBarHidden(true)
    }
    
    // Function to Remove Perfume from Favorites
    private func removeFromFavorites(perfume: FavoritePerfume) {
        favoritePerfumes.removeAll { $0.name == perfume.name }
    }
}

struct FavoritePerfume {
    let name: String
    let imageName: String
}

// **Favorite Perfume Card**
struct FavoritePerfumeCard: View {
    let perfume: FavoritePerfume
    let removeAction: () -> Void
    @State private var isFavorite: Bool = true
    
    var body: some View {
        ZStack {
            // Rectangle Background
            Image("rectangle_bg")
                .resizable()
                .scaledToFit()
                .frame(width: 169, height: 212)
                .cornerRadius(23)
            
            VStack {
                // Perfume Image
                Image(perfume.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 120)
                
                // Perfume Name
                Text(perfume.name)
                    .font(.custom("SF Pro Display", size: 16))
                    .foregroundColor(.white)
                    .padding(.top, 5)
            }
            .padding(.top, 15)
            
            // Heart Button (Toggle Favorite)
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        isFavorite.toggle()
                        if !isFavorite {
                            removeAction()
                        }
                    }) {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .resizable()
                            .frame(width: 23, height: 23)
                            .foregroundColor(Color(red: 81/255, green: 28/255, blue: 41/255))
                    }
                    .padding(.trailing, 12)
                    .padding(.top, 25)
                }
                Spacer()
            }
        }
        .frame(width: 170, height: 250)
    }
}



#Preview {
    FavoritesView()
}
