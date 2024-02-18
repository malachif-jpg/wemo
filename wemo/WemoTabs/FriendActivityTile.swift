//
//  FriendActivityTile.swift
//  wemo
//
//  Created by Hannah Kim on 2/18/24.
//

import SwiftUI
struct FriendActivityTile: View {
    var friendName: String
    var postTime: String // This is a string, but you might calculate this dynamically.
    var caption: String
    var profileImage: Image // Assume this image is in your assets.
    @State private var likesCount: Int
    @State private var isLiked = false // State to track like status
    
    init(friendName: String, postTime: String, caption: String, profileImage: Image, likesCount: Int) {
        self.friendName = friendName
        self.postTime = postTime
        self.caption = caption
        self.profileImage = profileImage
        _likesCount = State(initialValue: likesCount)
    }
    
    var body: some View {
        
        HStack(spacing: 16) {
            // Profile picture
            profileImage
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
            
            // Content and caption
            VStack(alignment: .leading, spacing: 4) {
                NavigationLink(destination: FriendAccount()) {
                    // Friend's name
                    Text(friendName)
                        .font(.headline)
                }
                // Post time
                Text(postTime)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                // Caption
                Text(caption)
                    .font(.body)
            }
            
            Spacer()
            
            // Heart icon and likes count
            HStack {
                Button(action: {
                    // Toggle the liked state and update likes count
                    isLiked.toggle()
                    if isLiked {
                        likesCount += 1
                    } else {
                        likesCount -= 1
                    }
                }) {
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .resizable()
                        .frame(width: 20, height: 18) // Corrected the height to show the icon
                        .foregroundColor(isLiked ? .red : .gray)
                }
                
                // Display likes count
                Text("\(likesCount)")
                    .font(.subheadline)
                    .foregroundColor(.black)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).fill(Color.white).shadow(color: .gray, radius: 2, x: 0, y: 2))
        .padding(.horizontal)
    }
}

struct FriendActivityTile_Previews: PreviewProvider {
    static var previews: some View {
        FriendActivityTile(friendName: "Tim",
                           postTime: "14 hours ago",
                           caption: "Completed 30 entries in a row!",
                           profileImage: Image("profile-pic-1"), // Replace with your actual image name
                           likesCount: 120
        )
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
