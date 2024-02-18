//
//  JournalScreen.swift
//  wemo
//
//  Created by Malachi Frazier on 2/8/24.
//

import SwiftUI

struct JournalScreen: View {
    @State private var showCreateEntrySheet = false
    @State private var searchText = ""
    @Environment(User.self) var mainUser
    @Environment(JournalModel.self) var journalModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack {
                        HStack{
                            Text("Hi, \(mainUser.name)!")
                                .bold()
                                .font(.title3)
                            Spacer()
                            NavigationLink(destination: Text("Settings")) {
                                Image(systemName: "gearshape").font(.system(size: 30))
                            }.padding(.top, 5)
                                .padding(.trailing, -5)
                        }.padding(.bottom, 1)
                        HStack{
                            Text(dateFormatted())
                            Spacer()
                            
                        }.padding(.bottom, 20)
                        HStack{
                            TextField("Search", text: $searchText)
                                .padding()
                                .padding(.leading, 35)
                                .background(
                                    Color.gray.opacity(0.2)
                                        .cornerRadius(10) //
                                        .overlay(
                                            HStack {
                                                Image(systemName: "magnifyingglass")
                                                    .foregroundColor(.gray)
                                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)    .padding(.leading, 8)
                                            }
                                        )
                                ).padding(.bottom, 25)
                            
                            
                        }
                        VStack{
                            NavigationLink(destination: (AuraView())){
                                ZStack{
                                    RoundedRectangle(cornerRadius: 30) // Rounded rectangle shape
                                        .fill(Color.designPrimary) // Fill color of the rectangle
                                        .frame(width: 340, height: 50) // Size of the rectangle
                                    
                                    HStack{
                                        Text("Your Weekly Aura Is Ready!") // Text to display
                                            .foregroundColor(.white) // Text color
                                            .font(.headline) // Font style
                                            .bold()
                                        Spacer();
                                        Image(systemName: "arrow.right.circle").font(.system(size: 25)).foregroundStyle(Color.designTextSecondary)
                                    }.padding(.horizontal)
                                       
                                    
                                        .shadow(radius: 10) // Optional shadow for a bit of depth
                                    
                                }
                                
                            }
                        
                    
                        
                        
                            if journalModel.entries.isEmpty {
                                Text("No journal entries :(")
                            } else {
                                ForEach(journalModel.entries, id: \.self) { entry in
                                    JournalEntryTile(entry: entry)
                                        .padding(.vertical)
                                }
                            }
                            
                        }
                        
                    }
                    .padding(.vertical)
                    .padding(.horizontal, 30)
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
