//
//  View+DismissKeyboard.swift
//  wemo
//
//  Created by Malachi Frazier on 2/18/24.
//

import Foundation

import SwiftUI

extension View {
    func dismissKeyboardOnTap() -> some View {
        self.onTapGesture {
            // Dismiss the keyboard
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}
