//
//  HelpScreen.swift
//  wemo
//
//  Created by Hannah Kim on 2/17/24.
//

import SwiftUI

struct HelpScreen: View {
    
    var body: some View {
        NavigationStack{
            ZStack{
                ScrollView{
                    VStack{
                        HStack{
                            Image(systemName: "questionmark.circle")
                                .font(.system(size: 50))
                        }
                        Spacer()
                        HStack{
                            Text("Discover Vita")
                                .bold()
                                .font(.largeTitle)
                        }
                        HStack{
                            VStack{
                                Text("Start your journey with Wemo’s chatbot, designed to connect you with your ") + Text("past self")
                                    .bold().foregroundColor(.designPrimary)
                                Text("Through Vita, you can dive into your journal entries to rediscover ")+Text("thoughts, feelings, and experiences")
                                    .bold().foregroundColor(.designPrimary)+Text(", building a deep conversation with the person you were.")
                                
                            }.padding(.leading, 30)
                            Image("help-image-1").resizable()
                                .aspectRatio(contentMode: .fit) //
                                .frame(width: 250, height: 250)
                                .padding(.trailing, -70)
                                .padding(.leading, -50)
                                .opacity(0.5)
                        }
                        
                        Spacer().frame(height: 20)
                        HStack{
                            Text("How to Begin a Simple Conversation")
                                .font(.system(size: 20))
                                .bold()
                        }
                        Spacer().frame(height: 20)
                        HStack{
                            VStack{
                                Text("Start Simple: ").bold().foregroundColor(.designPrimary)+Text("Begin by asking Vita questions like, \"What was on my mind this time last year?\" or \"How have my feelings about work evolved?\"")
                                Spacer()
                                Text("Specific Queries: ").bold().foregroundColor(.designPrimary)+Text("Target your questions to uncover detailed memories, such as \"Show me when I felt happiest in 2023.\"")
                                Spacer()
                                
                            }.padding(.leading, 7)
                            .padding(.horizontal, 20)
                                
                            Spacer()
                            
                        }
                        
                        Spacer().frame(height: 40)
                        HStack{
                            Text("Understanding Vita")
                                .font(.system(size: 20))
                                .bold()
                        }
                        Spacer().frame(height: 20)
                        HStack{
                            Image("help-image-2").resizable()
                                .aspectRatio(contentMode: .fit) //
                                .frame(width: 250, height: 250)
                                .padding(.leading, -40)
                                .padding(.trailing, -40)
                                .opacity(1)
                            VStack{
                                Text("Behind Vita's Responses: ").bold().foregroundColor(.designPrimary)+Text("Vita leverages Mixtral LLM to analyze your journal entries, offering responses that mirror your past thoughts and feelings.")
                                Spacer()
                                Text("Training and Ethics: ").bold().foregroundColor(.designPrimary)+Text("Vita is crafted with privacy and ethical AI practices at its core, ensuring a respectful approach to your personal history.")
                                
                            }.padding(.trailing, 20)
                            
                        }
                        
                        }
                        Spacer().frame(height: 20)
                        HStack{
                            Text("Need Assistance?")
                                .font(.system(size: 20))
                                .bold()
                        }
                    HStack{
                        VStack{
                            Text("Have questions or need help navigating your conversations with your past self?")
                            Spacer().frame(height: 15)
                            Text("Our support team is here to help you make the most out of your Wemo experience.")
                            
                        }.padding(.leading, 20)
                        Image("help-image-3").resizable()
                            .aspectRatio(contentMode: .fit) //
                            .frame(width: 250, height: 250)
                            .opacity(0.9)
                            .padding(.leading, -35)
                            .padding(.trailing, -45)
                        
                        
                    }
                        
                        
                        
                    }
                }
            }
            
        }
        
    
}

#Preview {
    HelpScreen()
       
}
