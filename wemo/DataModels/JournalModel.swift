//
//  JournalModel.swift
//  wemo
//
//  Created by Malachi Frazier on 2/17/24.
//

import Foundation
import Supabase

@Observable
public class JournalModel {
    var entries: [JournalEntry] = []
    
    // Manual init
    init(entries: [JournalEntry]) {
        self.entries = entries
    }
    
    // Init with Swift Data
    init() {
        self.entries = []
    }
    
    func fetchEntries(userId: String) async {
        do {
            let entries: [JournalEntry] = try await supabase.database.from("journal_entries")
                .select()
                .eq("user_id", value: userId)
                .order("created_at", ascending: false)
                .execute()
                .value
            
            self.entries = entries
            
        } catch {
            print("An error has been encountered while fetching journal entries: \(error)")
        }
    }
}
