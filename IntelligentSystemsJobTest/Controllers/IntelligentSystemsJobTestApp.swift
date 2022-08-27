//
//  IntelligentSystemsJobTestApp.swift
//  IntelligentSystemsJobTest
//
//  Created by Jakob Skov Søndergård on 19/08/2022.
//

import SwiftUI

@main
struct IntelligentSystemsJobTestApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
