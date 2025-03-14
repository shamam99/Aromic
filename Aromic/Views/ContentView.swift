//
//  ContentView.swift
//  Aromic
//
//  Created by Shamam Alkafri on 12/03/2025.
//


import SwiftUI
import AuthenticationServices

struct ContentView: View {
    @State private var showSplash = true
    @StateObject private var authViewModel = AuthViewModel()
    
    var body: some View {
        NavigationView {
            if authViewModel.isAuthenticated {
                HomeView()
            } else {
                loginView
            }
        }
        .onAppear {
            authViewModel.checkUserSession()
        }
    }
    
    var loginView: some View {
        ZStack {
            Image("BG")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                Text("It’s time to find a scent that matches you!")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, 80)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation {
                        showSplash = false
                    }
                }
            }
      
            VStack(spacing: 15) {
                Spacer()
                
                Image("logoApp") // ✅ Center Image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                    .padding()
                
                Spacer(minLength: 60)

                VStack(spacing: 15) {
                    Button(action: {
                        let request = ASAuthorizationAppleIDProvider().createRequest()
                        request.requestedScopes = [.fullName, .email]
                        let controller = ASAuthorizationController(authorizationRequests: [request])
                        controller.delegate = authViewModel
                        controller.performRequests()
                    }) {
                        HStack {
                            Image(systemName: "applelogo")
                            Text("Sign in with Apple")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 0.91, green: 0.78, blue: 0.75))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                    }
                }
                .padding(.horizontal, 40)
                .padding(.top, 70)

                Spacer()
            }
        }
    }
}

// ✅ Preview
#Preview {
    ContentView()
}
