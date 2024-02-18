//
//  wemoApp.swift
//  wemo
//
//  Created by Malachi Frazier on 2/17/24.
//

import SwiftUI
import SwiftData

@main
struct wemoApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    @State private var mainUser = User(name: "Hannah", userId: "b7a35889-a19c-42e8-b648-22dd102d227e")
    @State private var journal = JournalModel()
    @State private var loading = true
    @State private var isLoggedIn = true
   


    var body: some Scene {
        WindowGroup {
            if !isLoggedIn {
                LoadingScreen()
                    .task {
                        await journal.fetchEntries(userId: mainUser.userId)
                        loading = false
                    }
            } else {
                WemoTabView()
                    .environment(mainUser)
                    .environment(journal)
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
