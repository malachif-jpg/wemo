//
//  NewJournalEntry.swift
//  wemo
//
//  Created by Malachi Frazier on 2/17/24.
//

import SwiftUI
import Observation
import Supabase

@Observable
class NewJournalEntry {
    var title: String
    var content: String
    var date: Date
    var isPinned: Bool
    var images: [UIImage]
    
    private var journalId: String?
    
    init() {
        self.title = ""
        self.content = ""
        self.date = Date.now
        self.isPinned = false
        self.images = []
    }
    
    func currentFormattedDate() -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE, MMM dd"
            return formatter.string(from: Date())
        }
    
    
    func isJournalValid() -> Bool {
        guard self.title != "" else {
            return false
        }
        
        guard self.content != "" else {
            return false
        }
        
        return true
    }
    
    func publishJournal(userId: String) async {
        guard isJournalValid() else {
            print("Journal needs to be filled in")
            return
        }
        do {
            let entry: [String: AnyJSON] = try await supabase.database.from("journal_entries")
                .insert(
                    ["title": title,
                     "body": content,
                     "is_pinned": String(isPinned)], returning: .representation)
                .single()
                .execute()
                .value
                
            print("\(entry)")
            
            // Get id of the entry
            let entryId = (entry["entry_id"]!.stringValue)!
            
            // Create a static instance of images
            let localImages = images
            
            var imageUrls = [String]()
            
            // Use id to store potential images
            if !localImages.isEmpty {
                for i in 0..<images.count {
                    let fileName = try await _storeImage(
                        image: localImages[i],
                        fileName: "\(entryId)_\(i).jpg"
                    )
                    imageUrls.append(fileName)
                    
                }
            }
            
            // Update entry with image urls
            let returnedEntry: [String: AnyJSON] = try await supabase.database.from("journal_entries")
                .update(["image_urls": imageUrls], returning: .representation)
                .eq("entry_id", value: entryId)
                .single()
                .execute()
                .value
            
            print("\nRETURNED ENTRY: \(returnedEntry)")
            
            // then use this to decode a journal entry object and push it to the entries page then exit the create page
                
        } catch {
            print("An error occured: could not public journal, \(error)")
        }
    }
    
    private func _storeImage(image: UIImage, fileName: String) async throws -> String {
        guard let imageData = image.jpegData(compressionQuality: 1) else {
            throw CustomError.runtimeError("Error: could not get image data when storing new journal entry image")
        }
        
        try await supabase.storage.from("journal_images")
            .upload(path: fileName, file: imageData)
        
        return fileName
        
    }
    
    
}
