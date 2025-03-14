//
//  FavoritesView.swift
//  Aromic
//
//  Created by Shamam Alkafri on 12/03/2025.
//


import SwiftUI

struct FavoritesView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var favoritePerfumes: [PerfumeModel] = []
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background Image
                Image("BG")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack {
                    // Back Button
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss() // Navigate back correctly
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .padding(.leading, 25)
                        .padding(.top, 10)

                        Spacer()
                    }
                    .padding(.top, 60)

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
                            ForEach(favoritePerfumes, id: \.id) { perfume in
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
            .onAppear {
                loadFavorites()
            }
            .navigationBarHidden(true)
        }
    }
 
    // ✅ Fetch Favorites from CloudKit (FIXED)
    private func loadFavorites() {
        CloudKitManager.shared.fetchFavoritePerfumes(userID: UserDefaults.standard.string(forKey: "userID") ?? "") { perfumes in
            self.favoritePerfumes = perfumes
        }
    }
    
    // ✅ Remove Perfume from Favorites
    private func removeFromFavorites(perfume: PerfumeModel) {
        CloudKitManager.shared.removeFavoritePerfume(perfumeName: perfume.name) { success in
            if success {
                favoritePerfumes.removeAll { $0.id == perfume.id }
            }
        }
    }
}

// ✅**Favorite Perfume Card**
struct FavoritePerfumeCard: View {
    let perfume: PerfumeModel
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
                // ✅ Fixed Image for Perfume
                Image("Aromic")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 130, height: 150)

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
