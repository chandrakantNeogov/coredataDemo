//
//  coredataDemoApp.swift
//  coredataDemo
//
//  Created by Chandrakant  Kondke on 27/05/24.
//

import SwiftUI

@main
struct coredataDemoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
