//
//  PerfumeRecommendationView.swift
//  Aromic
//
//  Created by Shamam Alkafri on 12/03/2025.
//

import SwiftUI

struct PerfumeRecommendationView: View {
    @State private var currentIndex = 0
    
    let perfumes: [Perfume] = [
        Perfume(name: "Burberry Her", season: "Spring - Summer", notes: "Amber, Sweet, Wood, Powdery, Florals", kind: "Female Scent", imageName: "burberry"),
        Perfume(name: "Chanel No.5", season: "Winter - Fall", notes: "Aldehydic, Floral, Powdery", kind: "Female Scent", imageName: "chanel"),
        Perfume(name: "Dior Sauvage", season: "All Seasons", notes: "Citrus, Woody, Spicy", kind: "Male Scent", imageName: "dior"),
    ]
    
    var body: some View {
        ZStack {
            // Background Image
            Image("back1")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                // Top bar with close button
                HStack {
                    Button(action: {
                    }) {
                        Text("X")
                            .font(.custom("SF Pro Display", size: 32).weight(.bold))
                            .foregroundColor(Color.white)
                    }
                    .padding(.leading, 25)
                    .padding(.top, 10)

                    Spacer()
                }
                .padding(.top, 80)

                // Title
                Text("Your New Scents\nAre ..")
                    .font(.custom("SF Pro Display", size: 30).weight(.heavy))
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 25)
                    .padding(.top, 10)
                
                Spacer()

                ZStack {
                    Image("")
                        .resizable()
                        .scaledToFit()
                    
                    Image("perfume_shape")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 350)
                }
                .frame(maxWidth: .infinity)

                Spacer()

                HStack {
                    Button(action: {
                        if currentIndex > 0 {
                            currentIndex -= 1
                        }
                    }) {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                    }
                    .padding(.leading, 20)

                    Spacer()

                    Button(action: {
                        if currentIndex < perfumes.count - 1 {
                            currentIndex += 1
                        }
                    }) {
                        Image(systemName: "chevron.right")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                    }
                    .padding(.trailing, 20)
                }
                .padding(.top, -180)
                
                // Perfume details card
                ZStack(alignment: .topLeading) {
                    Image("Rectangle")
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width, height: 350)
                        .clipped()
                    
                    VStack(alignment: .leading, spacing: 15) {
                        DetailRow(title: "Name", value: perfumes[currentIndex].name)
                        DetailRow(title: "Season", value: perfumes[currentIndex].season)
                        DetailRow(title: "Notes", value: perfumes[currentIndex].notes)
                        DetailRow(title: "Kind", value: perfumes[currentIndex].kind)
                    }
                    .padding(.leading, 30)
                    .padding(.top, 90)
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom, -2)

            }
        }
        .navigationBarHidden(true)
    }
}

// Perfume Model
struct Perfume {
    let name: String
    let season: String
    let notes: String
    let kind: String
    let imageName: String
}

// Detail Row Component (With Star Icon)
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

