//
//  NexWell_App.swift
//  NexWell.
//
//  Created by Keoni Li on 8/12/23.
//

import SwiftUI

@main
struct NexWell_App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

