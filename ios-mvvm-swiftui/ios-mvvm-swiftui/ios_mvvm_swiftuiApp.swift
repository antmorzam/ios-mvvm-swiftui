//
//  ios_mvvm_swiftuiApp.swift
//  ios-mvvm-swiftui
//
//  Created by Antonio Moreno on 27/2/24.
//

import SwiftUI

@main
struct ios_mvvm_swiftuiApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
