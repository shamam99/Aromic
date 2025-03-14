//
//  LaunchView.swift
//  Aromic
//
//  Created by shaden on 09/09/1446 AH.
//

import SwiftUI

struct LaunchView: View {
    @State private var opacity = 0.0
    @State private var navigateToOnboarding = false
    @State private var navigateToHome = false
    @State private var navigateToLogin = false

    var body: some View {
        ZStack {
            if navigateToOnboarding {
                OnboardingView()
            } else if navigateToHome {
                HomeView()
            } else if navigateToLogin {
                ContentView()
            } else {
                // Splash Screen
                Color.black.ignoresSafeArea()
                
                Image("logoApp")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .opacity(opacity)
                    .padding(.bottom, 90)
                    
                    .onAppear {
                        withAnimation(.easeInOut(duration: 1.5)) {
                            opacity = 1.0
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation(.easeInOut(duration: 1.5)) {
                                opacity = 0.0
                            }
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                            checkUserState()
                        }
                    }
                
            }
            
        }
    }
    
    //  Check if user has completed onboarding and logged in
    private func checkUserState() {
        let hasSeenOnboarding = UserDefaults.standard.bool(forKey: "hasSeenOnboarding")
        let isLoggedIn = UserDefaults.standard.bool(forKey: "isAuthenticated")

        DispatchQueue.main.async {
            if isLoggedIn {
                navigateToHome = true
            } else if hasSeenOnboarding {
                navigateToLogin = true
            } else {
                navigateToOnboarding = true
            }
        }
    }
}

#Preview {
    LaunchView()
}
