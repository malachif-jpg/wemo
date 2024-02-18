//
//  LoadingScreen.swift
//  wemo
//
//  Created by Hannah Kim on 2/18/24.
//

import SwiftUI

struct LoadingScreen: View {
    var body: some View {
        
            VStack {
                
                Text("Unfolding your story, one page at a time...")
                
                    .font(.title2)
                    .foregroundColor(.black)
                    .padding(30)
                    .padding(.horizontal,20)
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .designPrimary))
                
                    .scaleEffect(2)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .edgesIgnoringSafeArea(.all)
        }
}

#Preview {
    LoadingScreen()
}
