//
//  JournalScreen.swift
//  wemo
//
//  Created by Malachi Frazier on 2/8/24.
//

import SwiftUI

struct JournalScreen: View {
    @State private var showCreateEntrySheet = false
    
    @Environment(User.self) var mainUser
    @Environment(JournalModel.self) var journalModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack {
                        HStack {
                            Text("Hi, \(mainUser.name)!")
                                .bold()
                                .font(.title3)
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        HStack {
                            Text(dateFormatted())
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        if journalModel.entries.isEmpty {
                            Text("No journal entries :(")
                        } else {
                            ForEach(journalModel.entries, id: \.self) { entry in
                                JournalEntryTile(entry: entry)
                                    .padding()
                            }
                        }
                        
                    }
                    .padding(.vertical)
                }
                .scrollIndicators(.hidden)
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Button {
                            showCreateEntrySheet = true
                        } label: {
                            ZStack {
                                Circle()
                                    .fill(Color(Color.designPrimary))
                                    .frame(width: 59, height: 59)
                                Image(systemName: "plus")
                                    .font(.system(size: 22))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                            }
                            .padding(.vertical)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("wemo")
                        .bold()
                        .font(.largeTitle)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: Text("Notifications")) {
                        Image(systemName: "bell.badge.fill")
                    }
                }
            }
            .fullScreenCover(isPresented: $showCreateEntrySheet) {
                CreateEntryView(isPresented: $showCreateEntrySheet)
            }
        }
    }
    
    private func dateFormatted() -> String {
        let dateFormatter: DateFormatter = {
                let formatter = DateFormatter()
                formatter.dateFormat = "MMMM d, yyyy"
                return formatter
            }()
        
        let formattedDate = dateFormatter.string(from: Date())
        
        return formattedDate
    }
}

#Preview {
    JournalScreen()
        .environment(User(name: "Hannah", userId: ""))
        .environment(JournalModel())
}
