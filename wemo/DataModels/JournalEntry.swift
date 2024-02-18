//
//  JournalEntry.swift
//  wemo
//
//  Created by Malachi Frazier on 2/17/24.
//

import Foundation

class JournalEntry: Hashable, Codable {
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
    var isPinned: Bool
    
    // Define custom coding keys
    enum CodingKeys: String, CodingKey {
        case entryId = "entry_id"
        case title
        case content = "body"
        case date = "created_at"
        case isPinned = "is_pinned"
    }
    
    init(entryId: String, title: String, content: String, date: Date) {
        self.entryId = entryId
        self.title = title
        self.content = content
        self.date = date
        self.isPinned = false
    }
    
    // Implementing init(from decoder: Decoder) to decode from JSON
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.entryId = try container.decode(String.self, forKey: .entryId)
        self.title = try container.decode(String.self, forKey: .title)
        self.content = try container.decode(String.self, forKey: .content)
        self.isPinned = try container.decode(Bool.self, forKey: .isPinned)
        
        // Decoding date, assuming it's encoded as a timestamp or in ISO8601 format
        let dateString = try container.decode(String.self, forKey: .date)
        let formatter = DateFormatter()
        print("DATE STRING: \(dateString)")
        
        // Attempt with the first format
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZZZZZ"
        if let date = formatter.date(from: dateString) {
            self.date = date
        } else {
            // Attempt with the second format if the first one fails
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            if let date = formatter.date(from: dateString) {
                self.date = date
            } else {
                // If both formats fail, throw an error
                throw DecodingError.dataCorruptedError(forKey: .date, in: container, debugDescription: "Date string does not match format expected by formatter.")
            }
        }
    }
    
    // If you also need to encode instances of JournalEntry back to JSON:
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(entryId, forKey: .entryId)
        try container.encode(title, forKey: .title)
        try container.encode(content, forKey: .content)
        
        // Encoding date as a string in ISO8601 format; adjust as needed
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZZZZZ"
        let dateString = formatter.string(from: date)
        try container.encode(dateString, forKey: .date)
    }
    
    func dateFormatted() -> String {
        let dateFormatter: DateFormatter = {
                let formatter = DateFormatter()
                formatter.dateFormat = "MMMM d, yyyy"
                return formatter
            }()
        
        let formattedDate = dateFormatter.string(from: self.date)
        
        return formattedDate
    }
    
}
