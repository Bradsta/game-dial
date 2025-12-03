//
//  GameDialApp.swift
//  GameDial
//

import SwiftUI

@main
struct GameDialApp: App {
    @StateObject private var gameCatalogue = GameCatalogue()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(gameCatalogue)
        }
    }
}
