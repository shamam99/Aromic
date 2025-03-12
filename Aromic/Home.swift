//
//  Home.swift
//  Aromic
//
//  Created by shaden on 12/09/1446 AH.
//

import SwiftUI


struct HomeView: View {
    let favorites = [
        ("BURBERRY HER", "burberry"),
        ("GRIS DIOR", "Dior"),
        ("GIORGIO ARMANI SI", "Giorgio")
    ]
    
    let wantToBuy = [
        ("CHANEL N5", "chanel"),
        ("GUCCI BLOOM", "gucci")
    ]
    
    
    var body: some View {
        NavigationView {
            ZStack {
                
                Image("HomeP")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView(showsIndicators: false) {
                    LazyVStack(alignment: .leading) {
                        // Header
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Hello Shamam")
                                  .font(
                                    Font.custom("SF Pro Display", size: 32)
                                      .weight(.semibold)
                                  )
                                  .multilineTextAlignment(.center)
                                  .foregroundColor(Color(red: 1, green: 0.96, blue: 0.93))
                                Text("What Are We Doing Today?")
                                    .font(.system(size: 16))
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            
                            Spacer()
                            
                           
                            Button(action: {
                                print("Settings Button Tapped")
                            }) {
                                Image(systemName: "gearshape.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 26, height: 26)
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 104)

                        Button(action: {
                            print("Discover Tapped")
                        }) {
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
                        
                        //Your Favorites
                        SectionTitle(title: "Your Favorites")
                
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(favorites, id: \.0) { item in
                                    NavigationLink(destination: PerfumeDetailView(perfumeName: item.0, imageName: item.1)) {
                                        PerfumeCard(imageName: item.1, name: item.0)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        // Want To Buy Section
                        SectionTitle(title: "Want To Buy")
                        
                        //ScrollView "Want To Buy"
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(wantToBuy, id: \.0) { item in
                                    NavigationLink(destination: PerfumeDetailView(perfumeName: item.0, imageName: item.1)) {
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
    }
}


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
            Image(imageName)
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
