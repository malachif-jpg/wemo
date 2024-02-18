//
//  ExpandingTextEditor.swift
//  wemo
//
//  Created by Malachi Frazier on 2/18/24.
//

import SwiftUI
import PhotosUI


struct ExpandingTextEditor: View {
    @Binding var text: String
    @Binding var height: CGFloat

    var body: some View {
        VStack {
            Spacer()
            ZStack(alignment: .topLeading) {
                // Placeholder
                if text.isEmpty {
                    Text("Type something...")
                        .foregroundColor(.gray)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 12)
                }
                
                TextEditor(text: $text)
                    .frame(minHeight: height, maxHeight: min(height, 600))
                    .scrollContentBackground(.hidden)
                    .onChange(of: text) {
                        self.height = min(calculateHeight(), 500)
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
        let targetWidth = UIScreen.main.bounds.width - 40
        let size = textView.sizeThatFits(CGSize(width: targetWidth, height: CGFloat.infinity))
        return size.height
    }
}




#Preview {
    ExpandingTextEditor(text: .constant(""), height: .constant(100))
}
