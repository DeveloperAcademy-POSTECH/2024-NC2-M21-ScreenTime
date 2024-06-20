//
//  SplashView.swift
//  Stoplight-NC2
//
//  Created by kyungsoolee on 6/13/24.
//

import SwiftUI

struct SplashView: View {
    @State private var isPresentedHomeView: Bool = false
    var body: some View {
        NavigationStack {
            VStack {
                Text("스플레쉬 뷰")
            }
            .navigationDestination(isPresented: $isPresentedHomeView) {
                HomeView()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation(.easeInOut(duration: 1)) {
                    isPresentedHomeView = true
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
