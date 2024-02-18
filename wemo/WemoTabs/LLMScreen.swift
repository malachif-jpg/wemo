//
//  LLMScreen.swift
//  wemo
//
//  Created by Hannah Kim on 2/17/24.
//

import SwiftUI

struct LLMScreen: View {
    @Environment(User.self) var mainUser
    @Environment(JournalModel.self) var journalModel
    @State var llmController: LLMController
    @State private var textFieldHeight: CGFloat = 40
    
    init(llmController: LLMController) {
        self.llmController = llmController
    }
    
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
                        .padding(.bottom)
                        
                        ForEach(llmController.messages, id: \.createdAt) { message in
                            if message.messageType == .user {
                                HStack {
                                    Spacer()
                                    VStack {
                                        Text("You")
                                        Text(message.message)
                                    }
                                        .frame(width: 300)
                                }
                            } else {
                                HStack {
                                    VStack {
                                        Text("Vita")
                                        Text(message.message)
                                    }
                                    .frame(width: 300)
                                    .padding()
                                    Spacer()
                                }
                            }
                        }
                        
                    }
                    .padding(.bottom, 50)
                }
                .dismissKeyboardOnTap()
                
                VStack {
                    Spacer()
                    
                    if llmController.showingPrompts {
                        ForEach(llmController.prompts, id: \.self) { prompt in
                            Button {
                                // Add prompt to current query
                                llmController.showingPrompts = false
                                llmController.currentQuery = prompt
                            } label: {
                                ZStack(alignment: .center) {
                                    RoundedRectangle(cornerRadius: 25)
                                        .fill(Color.designAccent)
                                        .frame(height: 45)
                                        .shadow(radius:1, y: 2)
                                    Text(prompt)
                                        .padding()
                                }
                                .padding(.bottom, 5)
                                .padding(.horizontal, 20)
                            }
                        }
                    }
                    
                    ZStack {
                        HStack(alignment: .center) {
                            ExpandingTextField(text: $llmController.currentQuery, height: $textFieldHeight)
                            
                            
                            Button {
                                // Send query
                                llmController.addNewMessage(messageType: .user, message: llmController.currentQuery)
                                llmController.chatResponse(query: llmController.currentQuery, journalModel: journalModel)
                                
                                //llmController.chatResponse(query: llmController.currentQuery)
                            } label: {
                                VStack {
                                    Spacer()
                                    ZStack {
                                        Circle()
                                            .fill(Color.designAccent)
                                            .frame(height: 40)
                                        Image(systemName: "paperplane.fill")
                                            .font(Font.customTitle2)
                                            .foregroundColor(Color.designTextPrimary)
                                            .padding(.horizontal)
                                    }
                                    .frame(height: 40)
                                }
                                
                            }
                        }
                    }
                    .frame(height: textFieldHeight)
                    .padding(.horizontal, 15)
                    .onChange(of: llmController.currentQuery) {
                        llmController.showingPrompts = false
                    }
                        
                }
                .padding(.bottom)
                
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: HelpScreen()) {
                        Image(systemName: "questionmark.circle")
                            .font(.system(size: 24))
                    }
                }
            }
        }
        
    }
}

#Preview {
    LLMScreen(llmController: LLMController())
        .environment(User(name: "Hannah", userId: ""))
}
