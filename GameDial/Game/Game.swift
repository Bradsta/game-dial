//
//  Game.swift
//  GameDial
//

import Foundation

struct Game: Codable, Identifiable {
    let id: Int
    let name: String
    let summary: String?
    let cover: Cover?
    let platforms: [Platform]?
    var status: GameStatus? = GameStatus.backlog
    
    struct Cover: Codable {
        let url: String
    }
    
    struct Platform: Codable {
        let name: String
    }
    
    func getCoverUrlStr() -> String {
        return ("https:" + (cover?.url ?? "")).replacingOccurrences(of: "t_thumb", with: "t_cover_big")
    }
}
