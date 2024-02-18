//
//  LLMScreen.swift
//  wemo
//
//  Created by Hannah Kim on 2/17/24.
//

import SwiftUI

struct LLMScreen: View {
    @Environment(User.self) var mainUser
    var body: some View {
        NavigationStack{
            ZStack{
                ScrollView{
                    VStack{
                        HStack{
                            Image("avatar").resizable()
                                .aspectRatio(contentMode: .fill) //
                                .frame(width: 200, height: 200)
                        }
                        Spacer().frame(height: 20)
                        HStack{
                            Text("I’m Vita, what would you like to remember?").bold().font(.system(size: 22))
                                .multilineTextAlignment(.center)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: HelpScreen()) {
                        Image(systemName: "questionmark.circle")
                            .font(.system(size: 30))
                    }
                }
            }
        }
        
    }
}

#Preview {
    LLMScreen()
        .environment(User(name: "Hannah", userId: ""))
}
