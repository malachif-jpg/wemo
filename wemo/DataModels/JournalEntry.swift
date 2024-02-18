//
//  JournalEntry.swift
//  wemo
//
//  Created by Malachi Frazier on 2/17/24.
//

import Foundation

class JournalEntry: Hashable {
    static func == (lhs: JournalEntry, rhs: JournalEntry) -> Bool {
        lhs.entryId == rhs.entryId
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(entryId)
    }
    
    let entryId: String
    var title: String
    var content: String
    var date: Date
    
    init(entryId: String, title: String, content: String, date: Date) {
        self.entryId = entryId
        self.title = title
        self.content = content
        self.date = date
    }
}
