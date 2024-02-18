//
//  FriendProfile.swift
//  wemo
//
//  Created by Hannah Kim on 2/18/24.
//

import SwiftUI

struct FriendActivity {
    var friendName: String
    var postTime: String
    var caption: String
    var profileImageName: String // Use the image name to load the image from assets
    var likesCount: Int
}

struct FriendsView: View {
    var activities: [FriendActivity]
    
    var body: some View {
        ScrollView {
            
            ForEach(activities.indices, id: \.self) { index in
                
                    FriendActivityTile(friendName: activities[index].friendName,
                                       postTime: activities[index].postTime,
                                       caption: activities[index].caption,
                                       profileImage: Image(activities[index].profileImageName), // Load image from assets
                                       likesCount: activities[index].likesCount)
                    .padding(.bottom)
                
            }.padding(.top, 30)
        }
    }
}

struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView(activities: [
            FriendActivity(friendName: "Tim", postTime: "14 hours ago", caption: "Completed 30 entries in a row!", profileImageName: "tim", likesCount: 120),
            FriendActivity(friendName: "Sarah", postTime: "1 day ago", caption: "Loved this new book!", profileImageName: "sarah", likesCount: 95),
            // Add more friends' activities here...
        ])
    }
}
