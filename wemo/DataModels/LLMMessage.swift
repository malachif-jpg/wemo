//
//  LLMMessage.swift
//  wemo
//
//  Created by Malachi Frazier on 2/18/24.
//

import Foundation

enum MessageType {
    case model
    case user
}

struct LLMMessage {
    let message: String
    let messageType: MessageType
    let createdAt: Date
    
    init(message: String, messageType: MessageType) {
        self.message = message
        self.messageType = messageType
        self.createdAt = Date.now
    }
}
