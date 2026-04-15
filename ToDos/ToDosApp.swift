//
//  ToDosApp.swift
//  ToDos
//
//  Created by Rohit Sankpal on 14/04/26.
//

import SwiftUI
import SwiftData

@main
struct ToDosApp: App {
    /// Use a versioned store name so schema changes (e.g. `Item` → `TodoItem`, new fields) do not
    /// try to open an incompatible existing database (which causes `loadIssueModelContainer`).
    private static let storeName = "ToDos_v2"

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            TodoItem.self,
        ])
        let modelConfiguration = ModelConfiguration(
            Self.storeName,
            schema: schema,
            isStoredInMemoryOnly: false
        )

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
