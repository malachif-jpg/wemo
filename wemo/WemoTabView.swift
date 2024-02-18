//
//  WemoTabView.swift
//  wemo
//
//  Created by Malachi Frazier on 2/17/24.
//

import SwiftUI

struct WemoTabView: View {
    @Environment(LLMController.self) var llmController
    var body: some View {
        
        TabView {
            JournalScreen()
                .tabItem {
                    Image(systemName: "book")
                }
            
            LLMScreen(llmController: llmController)
                .tabItem {
                    Image(systemName: "brain")
                }
            
            CommunityScreen()
                .tabItem {
                    Image(systemName: "figure.socialdance")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                }
        }
    }
}

#Preview {
    WemoTabView()
        .environment(User(name: "Hannah", userId: ""))
        .environment(JournalModel())
}
