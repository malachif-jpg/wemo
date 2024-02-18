//
//  Test.swift
//  wemo
//
//  Created by Malachi Frazier on 2/17/24.
//

import SwiftUI
import PhotosUI

struct SelectJournalImagesView: View {
    @State var selectedItem: PhotosPickerItem?
    @State private var data: Data?
    
    // Start with an empty array of images
    @State var images: [Image] = []
    let maxImages = 4
    
    // Define fixed sizes for grid items
    let itemHeight: CGFloat = 150
    let itemWidth: CGFloat = 150
    

    var body: some View {
        // Define the grid layout
        let columns: [GridItem] = Array(repeating: .init(.fixed(itemWidth)), count: images.isEmpty ? 1 : 2)
        
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(images.indices, id: \.self) { index in
                    imageWithRemoveButton(for: index)
                        .frame(width: itemWidth, height: itemHeight) // Set fixed size for each item
                }
                
                // Conditionally adjust the Add Button layout
                if images.count < maxImages {
                    PhotosPicker(selection: $selectedItem, matching: .images) {
                        VStack {
                            Image(systemName: "plus.circle")
                                .font(.title)
                                .foregroundStyle(Color.designTextSecondary)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .border(Color.designTextSecondary)
                    }
                    .frame(width: itemWidth, height: itemHeight)
                }
            }
            .padding()
            .onChange(of: selectedItem) {
                handleImageChanges(item: selectedItem)
            }
    }
    
    @ViewBuilder
    private func imageWithRemoveButton(for index: Int) -> some View {
        ZStack(alignment: .topTrailing) {
            images[index]
                .resizable()
                .scaledToFill()
                .frame(width: itemWidth, height: itemHeight)
                .clipped()
                .shadow(radius: 3)
            
            Button(action: {
                removeImage(at: index)
            }) {
                Image(systemName: "xmark.circle.fill")
                    .font(Font.system(size: 20))
                    .foregroundStyle(Color.designTextSecondary)
            }
            .padding(4)
        }
    }
    
    private func handleImageChanges(item: PhotosPickerItem?) {
        
        if let item = item {
            item.loadTransferable(type: Data.self) { result in
                switch result {
                case .success(let data):
                    if let data = data, let uiImage = UIImage(data: data) {
                        let image = Image(uiImage: uiImage)
                        images.append(image)
                        selectedItem = nil
                    } else {
                        print("\nError selecting photo: data is nil")
                    }
                case .failure(let failure):
                    fatalError("\(failure)")
                }
                
            }
        }
    }
    
    
    
    func removeImage(at index: Int) {
        print("\nRemove image button pressed")
        images.remove(at: index)
    }
}

#Preview {
    SelectJournalImagesView()
}
