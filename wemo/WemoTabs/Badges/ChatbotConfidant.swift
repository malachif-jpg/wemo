//
//  ChatbotConfidant.swift
//  wemo
//
//  Created by Hannah Kim on 2/18/24.
//

import SwiftUI

struct ChatbotConfidant: View {
    var body: some View {
        NavigationStack{
            ZStack{
                VStack{
                    Spacer()
                    Image("chatbot-confidant-badge").resizable()
                        .aspectRatio(contentMode: .fill) //
                        .frame(width: 150, height: 150)
                    Spacer().frame(height: 30)
                    Text("Chatbot Confidant")
                        .font(.title2)
                        .bold()
                    Spacer().frame(height: 20)
                    Text("Awarded for your first heart-to-heart with your chatbot — here’s to many more insightful conversations!")
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
                }
            }
        }
    }
}

#Preview {
    ChatbotConfidant()
}
