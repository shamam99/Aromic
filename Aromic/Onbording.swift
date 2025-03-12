//
//  Onbording.swift
//  Aromic
//
//  Created by shaden on 09/09/1446 AH.
//


import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0

    let pages = [
        OnboardingPageData(
            title: "Let's Start Finding Your Own Scent",
            description: "All your favorites will be safely saved also your amazing lists and collections",
            imageName: "Let's start Page"
        ),
        OnboardingPageData(
            title: "Discover Your Next Favorite Scent!",
            description: "By discover a scent that truly represents who you are using AI",
            imageName: "Discover Scent Page"
        ),
        OnboardingPageData(
            title: "A Scent That Matches You!",
            description: "Save the results you got in the favorites and make lists for future purchases",
            imageName: "Scent Page"
        )
    ]

    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(0..<pages.count, id: \.self) { index in
                    OnboardingPage(data: pages[index])
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            
            HStack {
                
                HStack(spacing: 8) {
                    ForEach(0..<pages.count, id: \.self) { index in
                        Circle()
                            .fill(index == currentPage ? Color.black : Color(.gray))
                            .frame(width: 8, height: 8)
                            
                    }
                }
                .frame(width: 50, height: 24, alignment: .center)
                .background(Color(red: 0.95, green: 0.85, blue: 0.85))
                .cornerRadius(100)
                .padding(.horizontal, 107)
              
                

                Spacer()
                
           
                if currentPage < pages.count - 1 {
                    Button(action: {
                        withAnimation {
                            currentPage += 1
                        }
                    }) {
                        Image(systemName: "arrow.right")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(Color("babypink"))
                            .padding(12)
                            .background(
                            Circle()
                        .strokeBorder(Color("babypink"), lineWidth: 5)
                        
                                           )
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                    }
                    .padding(.trailing, 20)
                }
            }
            .frame(width: 200) 
            
        }
        .background(Color.black.edgesIgnoringSafeArea(.all)) 
    }
}

 
struct OnboardingPageData {
    var title: String
    var description: String
    var imageName: String
}

// Onboarding
struct OnboardingPage: View {
    var data: OnboardingPageData

    var body: some View {
        ZStack {
            Image(data.imageName)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()
                
                Text(data.title)
                    .padding(.top, 104)
                    .font(Font.custom("SF Pro Display", size: 30).weight(.semibold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .frame(width: 320, alignment: .top)

                Text(data.description)
                    .font(Font.custom("SF Pro Display", size: 24))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .frame(width: 300, alignment: .top)
                    .padding(.top, 10)

                Spacer(minLength: 100)
            }
        }
    }
}

#Preview {
    OnboardingView()
}
