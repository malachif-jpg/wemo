//
//  JournalModel.swift
//  wemo
//
//  Created by Malachi Frazier on 2/17/24.
//

import Foundation

@Observable
public class JournalModel {
    var entries: [JournalEntry] = []
    
    // Manual init
    init(entries: [JournalEntry]) {
        self.entries = entries
    }
    
    // Init with Swift Data
    init() {
        self.entries = [JournalEntry(title: "Swift", content: "Data", date: Date.now)]
    }
    
    func loadEntries() {
        print("Load journal entries...")
    }
}
