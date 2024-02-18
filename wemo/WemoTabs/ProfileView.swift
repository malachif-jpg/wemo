//
//  ProfileView.swift
//  wemo
//
//  Created by Hannah Kim on 2/18/24.
//

import SwiftUI

struct ProfileView: View {
    @State private var journalModel = JournalModel()
    @State private var showCreateEntrySheet = false
    
    @Environment(User.self) var mainUser
    var body: some View {
        NavigationStack {
            ZStack {
                
                Rectangle()
                    .foregroundColor(.designPrimary) // Set the rectangle's color to purple
                    .frame(width: 1000, height: 120) // Specify the fixed size of the rectangle
                    .padding(.bottom, 100)
                Image("profile").resizable()
                    .aspectRatio(contentMode: .fill) //
                    .frame(width: 200, height: 200)
                HStack{
                    NavigationLink(destination: Text("Notifications")) {
                                Image(systemName: "bell.badge.fill")
                        
                            }
                    }
            }
            ZStack {
                 ScrollView {
                    VStack{
                         
                         
                        Text("Hi, \(mainUser.name)!")
                            .bold()
                            .font(.title2)
                        Spacer()
                        Text(dateFormatted())
                    }
                        
                    }
                    
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItem(placement: .principal) {
                    
                    ZStack {
                            // Background color
                            Rectangle()
                                .foregroundColor(Color.designPrimary) // Use your custom color here
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .edgesIgnoringSafeArea(.all) // Optional, to ensure it fills the available space
                                .padding(.horizontal, -40)
                                .padding(.top, -80)
                            
                            // Text on top of the background
                            Text("wemo")
                                .bold()
                                .font(.largeTitle)
                                .foregroundColor(.black) // Adjust text color as needed
                       
                        
                        
                        }
                }
                
                
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
    ProfileView()
        .environment(User(name: "Hannah", userId: ""))
}
