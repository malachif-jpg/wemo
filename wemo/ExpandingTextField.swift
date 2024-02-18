//
//  Test2.swift
//  wemo
//
//  Created by Malachi Frazier on 2/17/24.
//

import SwiftUI
import PhotosUI


struct ExpandingTextField: View {
    @Binding var text: String
    @Binding var height: CGFloat

    var body: some View {
        VStack {
            Spacer()
            ZStack(alignment: .topLeading) {
                // Placeholder
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.designAccent)
                    .shadow(radius: 1, y:2)
                
                if text.isEmpty {
                    Text("Type something...")
                        .foregroundColor(.gray)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 12)
                }
                
                TextEditor(text: $text)
                    .frame(minHeight: height, maxHeight: .infinity)
                    .scrollContentBackground(.hidden)
                    .onChange(of: text) {
                        self.height = min(calculateHeight(), 100)
                    }
                    .padding(4)
            
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func calculateHeight() -> CGFloat {
        let textView = UITextView()
        textView.text = text
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        let targetWidth = UIScreen.main.bounds.width - 100
        let size = textView.sizeThatFits(CGSize(width: targetWidth, height: CGFloat.infinity))
        return size.height
    }
}


