//
//  JournalEntryTile.swift
//  wemo
//
//  Created by Malachi Frazier on 2/8/24.
//

import SwiftUI

struct JournalEntryTile: View {
    @State var entry: JournalEntry
    
    var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.designTextSecondary)
                    .shadow(radius: 2, y: 2)
                    
                
                VStack(alignment: .leading) {
                    Spacer()
                    Text(entry.dateFormatted())
                        .font(Font.customBody)
                        .padding(.bottom, 5)
                    
                    Text(entry.title)
                        .font(Font.customSubtitle)
                        .bold()
                    Spacer().frame(height: 3)
                   
                    Text(entry.content)
                        .font(Font.customBody)
                        .fontWeight(.light)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        
                    HStack {
                        Spacer()
                        Button {
                            // Pin and unpin
                        } label: {
                            Image(systemName: "pin")
                        }
                        Button {
                            // More button
                        } label: {
                            Image(systemName: "ellipsis")
                        }
                    }
                    .padding(.top, 5)
                    
                }
                .padding(.vertical, 9)
                .padding(.horizontal,15)
                
            }

            .frame(height: 110)
    }
}

#Preview {
    JournalEntryTile(entry: JournalEntry(entryId: "123", title: "Awesome walk at lake lag today", content: "I went on a walk around lake lag today and it was SOOOOO sick!", date: Date.now))
}
