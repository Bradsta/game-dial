//
//  GameDex.swift
//  GameDial
//

import Foundation

class GameCatalogue: ObservableObject {
    @Published var games: [Game] = []

    private var fileURL: URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent("Catalogue.json")
    }
    
    init() {
        load()
    }

    func addGame(_ game: Game) {
        games.append(game)
        save()
    }

    func removeGame(_ game: Game) {
        if let index = games.firstIndex(where: { $0.id == game.id }) {
            games.remove(at: index)
            save()
        }
    }
    
    func updateGameStatus(_ game: Game, status: GameStatus) {
        if let index = games.firstIndex(where: { $0.id == game.id }) {
            games[index].status = status
            save()
        }
    }
    
    func isInCatalogue(_ game: Game) -> Bool {
        return games.firstIndex(where: { $0.id == game.id }) != nil
    }
    
    func save() {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(games) {
            try? encodedData.write(to: fileURL, options: .atomicWrite)
        }
    }

    func load() {
        let decoder = JSONDecoder()
        if let data = try? Data(contentsOf: fileURL),
           let decodedGames = try? decoder.decode([Game].self, from: data) {
            games = decodedGames
        }
    }
}
