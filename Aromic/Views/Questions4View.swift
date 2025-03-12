//
//  Questions4View.swift
//  Aromic
//
//  Created by Wajan Altalhan on 3/5/25.
//

import SwiftUI

struct Questions4View: View {
    var body: some View {
        ZStack{
            Image("BG")
                .resizable()
                .ignoresSafeArea()
            Text("Let's get to know you ")
                .font(.custom("SF Pro Display", size: 32))
                .fontWeight(.medium)
                .foregroundColor(.text)
                .multilineTextAlignment(.leading)
                .padding(.bottom, 550)
                .padding(.trailing,200 )
            Text("What are your favorite occaciones ?")
                .font(.custom("SF Pro Display", size: 20))
                .fontWeight(.semibold)
                .foregroundColor(.text)
                .multilineTextAlignment(.leading)
                .padding(.bottom, 440)
                .padding(.trailing, 40 )
            ZStack(alignment: .bottom) {
                Image("wedding")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 161, height: 196)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                LinearGradient(gradient: Gradient(colors: [Color.black.opacity(150), Color.black.opacity(0)]),
                               startPoint: .bottom,
                               endPoint: .center)
                .frame(height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("Weddings")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.bottom, 20)
            }
            .frame(width: 161, height: 196)
            .background(Color.black.opacity(0.9))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.trailing, 190)
            .padding(.bottom, 190)
            ZStack(alignment: .bottom) {
                Image("party")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 161, height: 196)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                LinearGradient(gradient: Gradient(colors: [Color.black.opacity(150), Color.black.opacity(0)]),
                               startPoint: .bottom,
                               endPoint: .center)
                .frame(height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("Party")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.bottom, 20)
            }
            .frame(width: 161, height: 196)
            .background(Color.black.opacity(0.9))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.leading, 190)
            .padding(.bottom, 190)
            ZStack(alignment: .bottom) {
                Image("casual")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 161, height: 196)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                LinearGradient(gradient: Gradient(colors: [Color.black.opacity(150), Color.black.opacity(0)]),
                               startPoint: .bottom,
                               endPoint: .center)
                .frame(height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("Casual")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.bottom, 20)
            }
            .frame(width: 161, height: 196)
            .background(Color.black.opacity(0.9))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.trailing, 190)
            .padding(.top, 230)
            ZStack(alignment: .bottom) {
                Image("work")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 161, height: 196)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                LinearGradient(gradient: Gradient(colors: [Color.black.opacity(150), Color.black.opacity(0)]),
                               startPoint: .bottom,
                               endPoint: .center)
                .frame(height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("Work")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.bottom, 20)
            }
            .frame(width: 161, height: 196)
            .background(Color.black.opacity(0.9))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.leading, 190)
            .padding(.top, 230)
            ZStack(alignment: .bottom) {
                Image("formal")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 161, height: 196)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                LinearGradient(gradient: Gradient(colors: [Color.black.opacity(150), Color.black.opacity(0)]),
                               startPoint: .bottom,
                               endPoint: .center)
                .frame(height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("Formal")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.bottom, 20)
            }
            .frame(width: 161, height: 196)
            .background(Color.black.opacity(0.9))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.trailing, 190)
            .padding(.top, 650)
            Button("Done") {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
            }
            .padding()
            .background(Color.button)
            .foregroundColor(.black)
            .cornerRadius(8)
            .padding(.top, 700)
            .padding(.leading,250)
            
        }
    }
}

#Preview {
    Questions4View()
}
