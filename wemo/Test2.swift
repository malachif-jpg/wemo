//
//  Test2.swift
//  wemo
//
//  Created by Malachi Frazier on 2/17/24.
//

import SwiftUI
import PhotosUI


struct PhotosSelector: View {
    @State var selectedItems: [PhotosPickerItem] = []
    @State private var data: Data?


    var body: some View {
        PhotosPicker(selection: $selectedItems, maxSelectionCount: 4, selectionBehavior: .continuousAndOrdered, matching: .images) {
            Text("Select Multiple Photos")
        }
    }
    
    func joe() {
        selectedItems[0].loadTransferable(type: Data.self) { result in
            switch result {
            case .success(let data):
                if let data = data {
                    self.data = data
                } else {
                    print("\nError selecting photo: data is nil")
                }
            case .failure(let failure):
                fatalError("\(failure)")
            }
        }
    }
}

#Preview {
    PhotosSelector()
}

