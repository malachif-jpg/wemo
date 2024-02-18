//
//  User.swift
//  wemo
//
//  Created by Malachi Frazier on 2/17/24.
//

import Foundation
import Observation

@Observable
class User {
    var name: String
    var userId: String
    
    init(name: String, userId: String) {
        self.name = name
        self.userId = userId
    }
}
