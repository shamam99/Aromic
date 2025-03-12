//
//  LaunchView.swift
//  Aromic
//
//  Created by shaden on 09/09/1446 AH.
//

import SwiftUI

struct LaunchView: View {
    @State private var opacity = 0.0
    @State private var showOnboarding = false

    var body: some View {
        ZStack {
            if showOnboarding {
                OnboardingView()
            } else {
                Color.black.ignoresSafeArea()

                Image("LOGO")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .opacity(opacity)
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
                            showOnboarding = true
                        }
                    }
            }
        }
    }
}
#Preview {
    LaunchView()
}
