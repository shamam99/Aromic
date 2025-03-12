//
//  Questions1View.swift
//  Aromic
//
//  Created by Wajan Altalhan on 3/4/25.
//

import SwiftUI

struct Questions1View: View {
    @State private var selectedGender = "Female"
    let genders = ["Female", "Male"]
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
            Text("How old are you ?")
                .font(.custom("SF Pro Display", size: 20))
                .fontWeight(.semibold)
                .foregroundColor(.text)
                .multilineTextAlignment(.leading)
                .padding(.bottom, 400)
                .padding(.trailing,200 )
            DatePicker(selection: /*@START_MENU_TOKEN@*/.constant(Date())/*@END_MENU_TOKEN@*/, displayedComponents: .date, label: { /*@START_MENU_TOKEN@*/Text("Date")/*@END_MENU_TOKEN@*/ })
                .labelsHidden()
                .foregroundColor(.button)
                .background(Color.button)
                .cornerRadius(10)
                .padding(.bottom, 270)
                .padding(.trailing,230 )
                .tint(.black)
            Text("What is your gender ?")
                .font(.custom("SF Pro Display", size: 20))
                .fontWeight(.semibold)
                .foregroundColor(.text)
                .multilineTextAlignment(.leading)
                .padding(.top, 500)
                .padding(.trailing,167 )
            Picker("Select Gender", selection: $selectedGender) {
                ForEach(genders, id: \.self) { gender in
                    Text(gender)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .labelsHidden()
            .foregroundColor(Color("button"))
            .background(Color("button"))
            .cornerRadius(10)
            .tint(.black)
            .padding(.top, 630)
            .padding(.trailing, 250)
            .fixedSize()
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
    Questions1View()
}
