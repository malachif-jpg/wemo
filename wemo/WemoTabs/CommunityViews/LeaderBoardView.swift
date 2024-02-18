//
//  LeaderBoardView.swift
//  wemo
//
//  Created by Hannah Kim on 2/18/24.
//

import SwiftUI

struct LeaderBoardView: View {
        var body: some View {
            NavigationStack {
                ZStack {
                    ScrollView(.vertical, showsIndicators: false){
                        VStack{
                            Image("leadership").resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 350, height: 160)
                                .padding(.vertical, 4)
                                .shadow(color: .gray, radius: 1, x: 0, y: 1)
                            
                        }.padding(.vertical, 240)
                        
                    }
                }
            }
        }
        
    }

    #Preview {
        LeaderBoardView()
    }
