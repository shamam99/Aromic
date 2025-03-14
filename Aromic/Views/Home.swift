//
//  HomeView.swift
//  Aromic
//
//  Created by Shamam Alkafri on 12/03/2025.
//

import SwiftUI

struct HomeView: View {
    @State private var favoritePerfumes: [PerfumeModel] = [] // ✅ Favorites from CloudKit
    @State private var firstName: String = "User" // ✅ Default until fetched from CloudKit

    let wantToBuy = [
        ("CHANEL N5", "chanel"),
        ("GUCCI BLOOM", "gucci")
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                Image("HomeP")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView(showsIndicators: false) {
                    LazyVStack(alignment: .leading) {
                        // ✅ Header (Dynamically Fetching First Name)
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Hello \(firstName)") // ✅ Dynamic User Name
                                    .font(.custom("SF Pro Display", size: 32).weight(.semibold))
                                    .foregroundColor(Color.white)
                                Text("What Are We Doing Today?")
                                    .font(.system(size: 16))
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            
                            Spacer()
                            
                            // Settings Button → Navigates to ProfileView
                            NavigationLink(destination: ProfileView()) {
                                Image(systemName: "person.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 32, height: 32)
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 104)
                        
                        // Discover Button → Navigates to ScentSelectionView
                        NavigationLink(destination: ScentSelectionView()) {
                            HStack {
                                Spacer()
                                Image(systemName: "sparkles")
                                    .font(.system(size: 18))
                                Text("Discover")
                                    .font(.system(size: 22, weight: .bold))
                                Spacer()
                            }
                            .padding()
                            .background(Color("babypink"))
                            .foregroundColor(.black)
                            .cornerRadius(20)
                            .shadow(radius: 5)
                        }
                        .padding(.horizontal)
                        .padding(.top, 38)
                        
                        // ✅ Fetch & Display Favorites from CloudKit
                        SectionTitle(title: "Your Favorites")
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                if favoritePerfumes.isEmpty {
                                    Text("No favorites added yet.")
                                        .font(.system(size: 18, weight: .medium))
                                        .foregroundColor(.white.opacity(0.7))
                                        .padding(.leading, 25)
                                } else {
                                    ForEach(favoritePerfumes, id: \.id) { perfume in
                                        NavigationLink(destination: FavoritesView()) {
                                            PerfumeCard(imageName: "Aromic", name: perfume.name) // ✅ Fixed Image
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        .onAppear {
                            loadFavorites()
                        }
                        
                        // Want To Buy Section (UNCHANGED)
                        SectionTitle(title: "Want To Buy")
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(wantToBuy, id: \.0) { item in
                                    NavigationLink(destination: FavoritesView()) {
                                        PerfumeCard(imageName: item.1, name: item.0)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }

                        Spacer()
                    }
                }
            }
        }
        .onAppear {
            loadUserName() // ✅ Load User’s Name on View Load
        }
    }

    // ✅ Fetch Favorites from CloudKit
    private func loadFavorites() {
        CloudKitManager.shared.fetchFavoritePerfumes(userID: UserDefaults.standard.string(forKey: "userID") ?? "") { perfumes in
            self.favoritePerfumes = perfumes
        }
    }

    // ✅ Fetch Logged-in User's First Name from CloudKit
    private func loadUserName() {
        CloudKitManager.shared.fetchUserData { user in
            if let user = user {
                let fullName = user.fullName
                let firstName = fullName.components(separatedBy: " ").first ?? "User" // ✅ Extracts First Name
                DispatchQueue.main.async {
                    self.firstName = firstName
                }
            }
        }
    }
}

// ✅ Section Title Component
struct SectionTitle: View {
    var title: String
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
            Spacer()
            Text("Details :")
                .font(.system(size: 14))
                .foregroundColor(.white.opacity(0.6))
        }
        .padding(.horizontal)
        .padding(.top, 10)
    }
}

struct PerfumeCard: View {
    var imageName: String
    var name: String
    
    var body: some View {
        VStack {
            Image(imageName) //  Always displays "Aromic" for now
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 140)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            
            Text(name)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: [Color("babypink"), Color.black]), startPoint: .top, endPoint: .bottom)
        )
        .cornerRadius(20)
        .shadow(radius: 4)
    }
}


struct PerfumeDetailView: View {
    var perfumeName: String
    var imageName: String
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 250)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                
                Text(perfumeName)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 10)
                
                Spacer()
            }
            .padding()
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
#Preview {
    
}
