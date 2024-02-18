//
//  WemoTabView.swift
//  wemo
//
//  Created by Malachi Frazier on 2/17/24.
//

import SwiftUI

struct WemoTabView: View {
    var body: some View {
        TabView {
            JournalScreen()
                .tabItem {
                    Image(systemName: "book")
                }
            
            Text("UPO + LLM")
                .tabItem {
                    Image(systemName: "brain")
                }
            
            Text("Social Aspect")
                .tabItem {
                    Image(systemName: "figure.socialdance")
                }
            
            Text("Profile")
                .tabItem {
                    Image(systemName: "person.fill")
                }
        }
    }
}

#Preview {
    WemoTabView()
}
