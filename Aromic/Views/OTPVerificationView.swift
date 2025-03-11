//
//  OTPVerificationView.swift
//  ScentMatchView
//
//  Created by Najla adel alabdullah on 11/09/1446 AH.
//

import SwiftUI

struct OTPVerificationView: View {
    @State private var otp: [String] = Array(repeating: "", count: 4)
    @FocusState private var focusedIndex: Int?
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("background") // استبدلها بصورة الخلفية الخاصة بك
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Text("Email OTP Verification")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Enter the verification code we just sent to your email.")
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                    
                    // إدخال OTP في مربعات منفصلة
                    HStack(spacing: 15) {
                        ForEach(0..<4, id: \.self) { index in
                            TextField("", text: $otp[index])
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.center)
                                .frame(width: 50, height: 50)
                                .background(Color.white.opacity(0.2))
                                .cornerRadius(10)
                                .font(.title)
                                .foregroundColor(.white)
                                .focused($focusedIndex, equals: index)
                                .onChange(of: otp[index]) { newValue in
                                    if newValue.count > 1 {
                                        otp[index] = String(newValue.prefix(1))
                                    }
                                    if !newValue.isEmpty {
                                        focusedIndex = (index < 3) ? index + 1 : nil
                                    }
                                }
                        }
                    }
                    .padding(.top, 10)
                    
                    Button(action: {
                        // إعادة إرسال الكود
                        print("Resend OTP")
                    }) {
                        Text("Didn’t receive code? Resend")
                            .foregroundColor(.white.opacity(0.9))
                            .underline()
                    }
                    
                    Button(action: {
                        let enteredOTP = otp.joined()
                        print("Entered OTP: \(enteredOTP)")
                        // التحقق من الكود هنا
                    }) {
                        Text("Verify OTP")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 0.91, green: 0.78, blue: 0.75))
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 40)
                    .padding(.top, 10)
                }
            }
        }
    }
}

// معاينة الشاشة
struct OTPVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        OTPVerificationView()
    }
}
