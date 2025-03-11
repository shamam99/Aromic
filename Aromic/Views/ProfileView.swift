//
//  ProfileView.swift
//  ScentMatchView
//
//  Created by Najla adel alabdullah on 11/09/1446 AH.
//
import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("BG") // Replace with your actual image name
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack(spacing: 15) { // Reduced spacing to bring elements closer
                    Spacer(minLength: 10) // Adjusted space to move content slightly up
                    ProfileHeader()
                    ProfileDetails()
                    DeleteAccountButton()
                    Spacer()
                }
                .padding()
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        // Action for back button
                        print("Back button tapped")
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
}

// MARK: - Profile Header
struct ProfileHeader: View {
    var body: some View {
        HStack(spacing: 12) { // Reduced spacing between image and text
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundColor(.white)
            Text("Shamam Alkafri")
                .font(.title)
                .foregroundColor(.white)
                .bold()
                .padding(.top, 2) // Adjusted padding to move text slightly up
            Spacer()
        }
        .padding()
    }
}

// MARK: - Profile Details
struct ProfileDetails: View {
    var body: some View {
        VStack(spacing: 20) { // Reduced spacing between rows
            HStack(spacing: 20) { // Reduced spacing between columns
                ProfileRow(icon: "person.fill", title: "Female")
                ProfileRow(icon: "calendar", title: "0/0/0000")
            }
            .overlay(Rectangle().stroke(Color.white.opacity(0.2), lineWidth: 1))
            
            ProfileRow(icon: "envelope.fill", title: "Shamam24@gmail.com", isUnderlined: true)
            ProfileRow(icon: "phone.fill", title: "+966000000000")
            ProfileRow(icon: "sun.max.fill", title: "Appearance")
            ProfileRow(icon: "headphones", title: "Customer Service")
        }
        .padding()
    }
}

// MARK: - Profile Row Component
struct ProfileRow: View {
    var icon: String
    var title: String
    var isUnderlined: Bool = false
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.white)
                .font(.title2)
            
            Text(title)
                .foregroundColor(.white)
                .font(.title2)
                .underline(isUnderlined)
            Spacer()
        }
        .padding()
        .overlay(Rectangle().stroke(Color.white.opacity(0.2), lineWidth: 1))
    }
}

// MARK: - Delete Account Button
struct DeleteAccountButton: View {
    var body: some View {
        Button(action: {
            print("Delete Account")
        }) {
            Text("Delete My Account")
                .font(.title2)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(red: 0.4, green: 0.1, blue: 0.15))
                .cornerRadius(10)
        }
        .padding(.top, 15) // Reduced spacing above button
    }
}

// MARK: - Preview
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
