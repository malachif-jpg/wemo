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
                    .frame(width: 1000, height: 220) // Specify the fixed size of the rectangle
                    .padding(.bottom, 10)
                    .ignoresSafeArea()
                Image("profile").resizable()
                    .aspectRatio(contentMode: .fill) //
                    .frame(width: 200, height: 200)
                
                
            }
            ZStack {
                 
                    VStack{
                         
                        Text("Hi, \(mainUser.name)!")
                            .bold()
                            .font(.title2)
                        Spacer()
                        Text(dateFormatted())
                        Spacer().frame(height: 20)
                        
                        // count-section
                        ZStack {
                                RoundedRectangle(cornerRadius: 40) // Specify the corner radius
                                    .fill(Color.white)
                                    .frame(width: 350, height: 75)
                                    .shadow(radius: 2, y: 3)
                            HStack{
                                Spacer()
                                Spacer()

                                VStack{
                                    
                                    Text("10")
                                        .foregroundColor(.black) // Text color
                                        .bold()
                                        .font(.system(size: 18))
                                    
                                    Text("Entries")
                                        .foregroundColor(.black) // Text color
                                        .font(.system(size: 14))
                                    
                                }
                                Spacer()
                                Rectangle()
                                        .fill(Color.gray) // Set the color of your line
                                        .frame(width: 1, height: 50) // Set the width and height of the line
                                Spacer()
                                VStack{
                                    Text("3")
                                        .foregroundColor(.black) // Text color
                                        .bold()
                                        .font(.system(size: 18))
                                    Text("Streaks")
                                        .foregroundColor(.black) // Text color
                                        .font(.system(size: 14))
                                }
                                Spacer()
                                Rectangle()
                                        .fill(Color.gray) // Set the color of your line
                                        .frame(width: 1, height: 50) // Set the width and height of the line
                                Spacer()
                                VStack{
                                    Text("2")
                                        .foregroundColor(.black) // Text color
                                        .bold()
                                        .font(.system(size: 18))
                                    Text("Badges")
                                        .foregroundColor(.black) // Text color
                                        .font(.system(size: 14))
                                }
                                Spacer()
                                Spacer()
                                
                            }.multilineTextAlignment(.center)
                                }
                        Spacer().frame(height: 40)
                        
                        
                        Text("BADGES").bold().foregroundColor(.designPrimary).font(.system(size: 20))
                        
                        ScrollView(.vertical, showsIndicators: false)  {
                        // badges (3 rows, 2 columns)
                        
                            HStack{
                            Spacer()
                                NavigationLink(destination: FirstPageFlyer()){
                                    Image("first-page-flyer-badge").resizable()
                                        .aspectRatio(contentMode: .fill) //
                                    .frame(width: 150, height: 150)}
                            Spacer()
                                NavigationLink(destination:StreakStarterBadge()){
                                    Image("streak-starter-badge").resizable()
                                        .aspectRatio(contentMode: .fill) //
                                        .frame(width: 150, height: 150)
                                }
                            Spacer()
                        }
                        HStack{
                            Spacer()
                            
                            Image("locked-badge").resizable()
                                .aspectRatio(contentMode: .fill) //
                                .frame(width: 150, height: 150)
                            Spacer()
                            Image("locked-badge").resizable()
                                .aspectRatio(contentMode: .fill) //
                                .frame(width: 150, height: 150)
                            Spacer()
                        }
                        HStack{
                            Spacer()
                            Image("locked-badge").resizable()
                                .aspectRatio(contentMode: .fill) //
                                .frame(width: 150, height: 150)
                            Spacer()
                            Image("locked-badge").resizable()
                                .aspectRatio(contentMode: .fill) //
                                .frame(width: 150, height: 150)
                            Spacer()
                        }
                        
                    }
                        
                    }
                    
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("wemo")
                        .bold()
                        .font(.largeTitle)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: Text("Settings")) {
                        Image(systemName: "gearshape.fill")
                    }.padding(.trailing, 10)
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
