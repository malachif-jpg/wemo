//
//  MultilineTextField.swift
//  wemo
//
//  Created by Malachi Frazier on 2/17/24.
//

import SwiftUI
import UIKit

struct MultilineTextField: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        
        // Apply basic styling to match SwiftUI TextField
        textView.font = .systemFont(ofSize: 17)
        textView.textColor = UIColor(Color.designTextSecondary)
        textView.backgroundColor = .clear
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        // Placeholder support
        textView.text = placeholder
        textView.textColor = UIColor(Color.designTextSecondary)
        
        textView.isScrollEnabled = true
        
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        if uiView.text == placeholder && !text.isEmpty {
            uiView.text = text
            uiView.textColor = UIColor(Color.designTextSecondary) // Normal text color
        } else if text.isEmpty {
            uiView.text = placeholder
            uiView.textColor = UIColor(Color.designTextSecondary)
        } else {
            uiView.text = text
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate, UIScrollViewDelegate {
        var parent: MultilineTextField
        
        init(_ multilineTextField: MultilineTextField) {
            self.parent = multilineTextField
        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.parent.text = textView.text
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.text == parent.placeholder {
                textView.text = ""
                textView.textColor = UIColor(Color.designTextSecondary) // Normal text color
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.isEmpty {
                textView.text = parent.placeholder
                textView.textColor = UIColor(Color.designTextSecondary)
            }
        }
        
        // UIScrollViewDelegate method to detect scrolling
                func scrollViewDidScroll(_ scrollView: UIScrollView) {
                    let dragVelocity = scrollView.panGestureRecognizer.velocity(in: scrollView).y
                    if dragVelocity > 0 { // Scrolling up
                        // Dismiss the keyboard
                        scrollView.resignFirstResponder()
                    }
                }
    }
}
