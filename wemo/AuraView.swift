//
//  AuraSwift.swift
//  wemo
//
//  Created by Hannah Kim on 2/18/24.
//

import SwiftUI

struct AuraView: View {
    var body: some View {
        NavigationStack{
            ZStack{
                VStack{
                    Spacer()
                    Image("aura-example").resizable()
                        .aspectRatio(contentMode: .fill) //
                        .frame(width: 300
                               , height: 300)
                    Spacer().frame(height: 30)
                    Text("Your Weekly Aura")
                        .font(.title2)
                        .bold()
                    Spacer().frame(height: 20)
                    Text("This Aura maps out the visual landscape of your past week, using your journal entries as its guide.")
                    Spacer().frame(height: 20)
                    Text("Take a moment to consider what these patterns might reveal about your current path.").fontWeight(.light)
                    Spacer()
                    Button(action: {
                        // Action for the button when it is tapped
                        print("Share button tapped")
                    }) {
                        Text("Share                                                  ")
                            .bold()
                            .foregroundColor(.white) // Text color
                            .padding() // Add padding around the text to make the button larger
                            .background(Color.designPrimary) // Button background color
                            .cornerRadius(30) // Rounded corners
                            .shadow(radius: 10) // Shadow effect
                            .frame(minWidth: 0, maxWidth: .infinity)
                        
                    }.padding(.horizontal)
                    Spacer()
                }.padding(.horizontal, 40).multilineTextAlignment(.center)
                
            }
        }
    }
        
}

#Preview {
    AuraView()
}
