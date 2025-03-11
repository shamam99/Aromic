//
//  SignUpView.swift
//  ScentMatchView
//
//  Created by Najla adel alabdullah on 04/09/1446 AH.
//

import SwiftUI

struct SignUpView: View {
    @State private var firstName = "firstName"
    @State private var lastName = "lastName"
    @State private var email = "email"
    @State private var password = "password"
    @Environment(\ .presentationMode) var presentationMode

    var body: some View {
        ZStack {
            Image("background") // تأكد أن الصورة مضافة إلى Assets.xcassets
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .bold))
                    }
                    Spacer()
                }
                .padding(.top, 40)
                .padding(.leading, 20)
                
                Text("Let’s Sign You Up")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                
                VStack(spacing: 16) {
                    TextField("First name", text: $firstName)
                        .padding()
                        .background(Color(red: 0.98, green: 0.94, blue: 0.91))
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                        .foregroundColor(.gray)
                    
                    TextField("Last name", text: $lastName)
                        .padding()
                        .background(Color(red: 0.98, green: 0.94, blue: 0.91))
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                        .foregroundColor(.gray)
                    
                    TextField("Email address", text: $email)
                        .padding()
                        .background(Color(red: 0.98, green: 0.94, blue: 0.91))
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                        .foregroundColor(.gray)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(red: 0.98, green: 0.94, blue: 0.91))
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                        .foregroundColor(.gray)
                }
                .padding(.top, 10)
                
                NavigationLink(destination: OTPVerificationView().navigationBarHidden(true)) {
                    Text("Sign up")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(Color(red: 0.91, green: 0.78, blue: 0.75))
                        .cornerRadius(12)
                }
                .padding(.horizontal, 20)
                .padding(.top, 30)
                
                Spacer()
            }
            .padding(.top, 20)
        }
        .navigationBarBackButtonHidden(true) // إخفاء زر الرجوع الافتراضي
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SignUpView()
        }
    }
}
