//
//  CreateEntryView.swift
//  wemo
//
//  Created by Malachi Frazier on 2/17/24.
//

import SwiftUI

struct CreateEntryView: View {
    @Binding var isPresented: Bool
    @State var entry = NewJournalEntry()
    
    @Environment(User.self) var mainUser
    @Environment(JournalModel.self) var journal
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                
                ZStack {
                    HStack {
                        // Cancel button
                        Button {
                            isPresented = false
                        } label: {
                            Text("Cancel")
                                .font(.customSubtitle)
                                .foregroundStyle(Color.designTextSecondary)
                                .underline()
                        }
                        
                        Spacer()
                        
                        // Pin button
                        Button {
                            print("pin entry")
                        } label: {
                            Image(systemName: "pin")
                                .font(.customSubtitle)
                                .foregroundStyle(Color.designTextSecondary)
                        }
                    }
                    HStack {
                        Spacer()
                        
                        Text("\(entry.currentFormattedDate())")
                            .font(.customSubtitle)
                            .bold()
                            .foregroundStyle(Color.designTextSecondary)
                        
                        Spacer()
                    }
                }
                
                ScrollView {
                    
                    
                    SelectJournalImagesView(entry: entry)
                    
                    
                    
                    VStack(spacing: 5) {
                        TextField("", text: $entry.title)
                            .onChange(of: entry.title.count) {
                                // If the new value exceeds 30 characters, trim the text to the first 30 characters
                                if entry.title.count > 30 {
                                    entry.title = String(entry.title.prefix(30))
                                }
                            }
                            .font(.customTitle1)
                            .bold()
                            .foregroundStyle(Color.designTextSecondary)
                            .placeholder(when: entry.title.isEmpty) {
                                Text("Journal Title")
                                    .font(.customTitle1)
                                    .bold()
                                    .foregroundStyle(Color.designTextSecondary)
                                    .padding(.leading, 2)
                                    .opacity(0.5)
                            }
                        
                        TextField("", text: $entry.content, axis: .vertical)
                            .font(.customSubtitle)
                            .foregroundStyle(Color.designTextSecondary)
                            .placeholder(when: entry.content.isEmpty) {
                                Text("Journal Body")
                                    .font(.customSubtitle)
                                    .foregroundStyle(Color.designTextSecondary)
                                    .padding(.leading, 2)
                                    .opacity(0.5)
                            }
                    }
                    
                    Spacer()
                    
                }
                .scrollIndicators(.hidden)
                .gesture(DragGesture().onChanged({ value in
                    // Check if the drag indicates a scroll upwards
                    if value.translation.height > 0 {
                        // Dismiss the keyboard
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                }))
                
                
            }
            .padding(.horizontal)
            
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    
                    Button {
                        Task {
                            do {
                                isPresented = false
                                if let returnedEntry = try await entry.publishJournal(userId: mainUser.userId) {
                                    journal.entries.insert(returnedEntry, at: 0)
                                }
                            } catch {
                                print("Error: \(error)")
                            }
                            
                        }
                        print("Save journal")
                        // Done button
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(style: StrokeStyle(lineWidth: 1))
                                .foregroundStyle(Color.designTextSecondary)
                            Text("Save")
                                .font(Font.customSubtitle)
                                .foregroundStyle(Color.designTextSecondary)
                        }
                        .frame(width: 70, height: 30)
            
                    }
                
                }
                .frame(height: 40)
                .padding(.horizontal)
                .padding(.bottom, 10)
                
            }
            
        }
        .background(Color.designPrimary)
    }
}

#Preview {
    CreateEntryView(isPresented: .constant(true))
        .environment(User(name: "", userId: ""))
        .environment(JournalModel())
}
