//
//  LoginView().swift
//  wemo
//
//  Created by Hannah Kim on 2/18/24.
//

import SwiftUI

struct LoginView: View {
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
                        NavigationLink(destination: WemoTabView()) {
                            Image(systemName: "questionmark.circle")
                                .font(.system(size: 30))
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
    LoginView()
        .environment(User(name: "Hannah", userId: ""))
}
