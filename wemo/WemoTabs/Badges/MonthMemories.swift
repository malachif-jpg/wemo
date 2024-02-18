//
//  MonthMemories.swift
//  wemo
//
//  Created by Hannah Kim on 2/18/24.
//

import SwiftUI

struct MonthMemories: View {
    var body: some View {
        NavigationStack{
            ZStack{
                VStack{
                    Spacer()
                    Image("month-memories-badge").resizable()
                        .aspectRatio(contentMode: .fill) //
                        .frame(width: 150, height: 150)
                    Spacer().frame(height: 30)
                    Text("Month of Memories")
                        .font(.title2)
                        .bold()
                    Spacer().frame(height: 20)
                    Text("30 days of dedication to documenting your journey — each entry a step toward a lifetime of memories.").multilineTextAlignment(.center).padding(.horizontal,40)
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
    MonthMemories()
}
