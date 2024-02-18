//
//  CommunityScreen.swift
//  wemo
//
//  Created by Hannah Kim on 2/18/24.
//

import SwiftUI

struct CommunityScreen: View {
    @State private var isShowingFriends = true // State to track which view to show

        var body: some View {
            NavigationStack {
                VStack {
                    // Custom Toggle
                    HStack(spacing: 4) {
                        // Friends Button
                        Button(action: {
                            isShowingFriends = true
                        }) {
                            Text("Friends")
                                .foregroundColor(isShowingFriends ? .white : .designPrimary)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 50)
                                .background(isShowingFriends ? Color.designPrimary : Color.white)
                                .cornerRadius(20)
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.designPrimary, lineWidth: 2)
                        )

                        // Leaderboard Button
                        Button(action: {
                            isShowingFriends = false
                        }) {
                            Text("Leaderboard")
                                .foregroundColor(!isShowingFriends ? .white : .designPrimary)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 30)
                                .background(!isShowingFriends ? Color.designPrimary : Color.white)
                                .cornerRadius(20)
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.designPrimary, lineWidth: 2)
                        )
                    }

                    // Content based on toggle state
                    if isShowingFriends {
                        FriendsView(activities: [
                            FriendActivity(friendName: "Tim", postTime: "14 hours ago", caption: "Completed 30 entries in a row!", profileImageName: "profile-pic-1", likesCount: 3),
                            FriendActivity(friendName: "Sarah", postTime: "1 day ago", caption: "Completed her first entry!", profileImageName: "profile-pic-2", likesCount: 9),
                            FriendActivity(friendName: "Alex", postTime: "1 day ago", caption: "Just earned the Streak Starter Badge!", profileImageName: "profile-pic-3", likesCount: 5),
                            FriendActivity(friendName: "Jamie", postTime: "3 days ago", caption: "On a 10-day streak!", profileImageName: "profile-pic-4", likesCount: 7),
                            FriendActivity(friendName: "Christina", postTime: "4 days ago", caption: "Wrote a thoughtful entry about gratitude.", profileImageName: "profile-pic-5", likesCount: 8),
                            FriendActivity(friendName: "Pat", postTime: "5 days ago", caption: "Celebrated a 50-day journaling streak!", profileImageName: "profile-pic-6", likesCount: 12),
                            FriendActivity(friendName: "Morgan", postTime: "6 days ago", caption: "Started the Journey of Reflection badge.", profileImageName: "profile-pic-7", likesCount: 4),
                        ])
                    } else {
                        LeaderBoardView()
                    }
                    Spacer()
                }.padding(.top, 30)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("wemo")
                            .bold()
                            .font(.largeTitle)
                    }
                    
                }
               
            }
            
        }
    
    }


struct CommunityScreen_Previews: PreviewProvider {
    static var previews: some View {
        CommunityScreen()
    }
}
