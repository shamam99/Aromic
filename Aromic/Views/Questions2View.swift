//
//  Questions2View.swift
//  Aromic
//
//  Created by Wajan Altalhan on 3/4/25.
//

import SwiftUI

struct Questions2View: View {
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
            Text("What are your favorite brands ?")
                .font(.custom("SF Pro Display", size: 20))
                .fontWeight(.semibold)
                .foregroundColor(.text)
                .multilineTextAlignment(.center)
                .padding(.bottom, 300)
            TextField("Favorite Brands", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                .padding()
                .background(Color.text)
                .foregroundColor(.black)
                .cornerRadius(8)
                .frame(width: 330, height: 50)
                .padding(.bottom, 100)
            Button("Next") {
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
    Questions2View()
}
