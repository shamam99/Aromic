//
//  ContentView.swift
//  ScentMatchView
//
//  Created by Najla adel alabdullah on 04/09/1446 AH.
//


import SwiftUI

struct ContentView: View {
    @State private var showSplash = true

    var body: some View {
        NavigationView {
            ZStack {
                Image("BG") // Replace with your actual image name
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Image("scent_icon") // Replace with your actual image asset
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                    
                    Text("It’s time to find a scent that matches you!")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        withAnimation {
                            showSplash = false
                        }
                    }
                }
          
                // Main Content
                VStack(spacing: 20) {
                    Spacer()
                    Spacer()
                    Image("photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                        .padding()
                    
                    Spacer(minLength: 50)
                   
                    VStack(spacing: 15) {
                        NavigationLink(destination: SignUpView()) {
                            Text("Sign up")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(red: 0.91, green: 0.78, blue: 0.75))
                                .foregroundColor(.black)
                                .cornerRadius(10)
                        }
                        
                        Button(action: {}) {
                            Text("Log in")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(red: 0.91, green: 0.78, blue: 0.75))
                                .foregroundColor(.black)
                                .cornerRadius(10)
                        }
                        
                        Button(action: {}) {
                            HStack {
                                Image(systemName: "applelogo")
                                Text("Continue with Apple")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 0.91, green: 0.78, blue: 0.75))
                            .foregroundColor(.black)
                            .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal, 40)
                    
                    Spacer()
                }
            }
        }
    }
}

struct ScentMatchView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

#Preview {
    ContentView()
}
