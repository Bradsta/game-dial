//
//  SearchView.swift
//  GameDial
//

import SwiftUI

struct SearchView: View {
    @FocusState private var isFocused: Bool
    @State private var searchText = ""
    @State private var searchResults: [Game] = []
    @State private var selectedGame: Game?
    
    @EnvironmentObject var gameCatalogue: GameCatalogue

    let igdbService = IGDBService()
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        VStack {
            TextField("Search", text: $searchText, onCommit: {
                if !searchText.isEmpty {
                    fetchGames()
                }
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            .focused($isFocused)
            
            ScrollView {
                LazyVGrid(columns: columns, content: {
                    ForEach(searchResults, id: \.id) { game in
                        GameCard(game: game)
                        .onTapGesture {
                            selectedGame = game
                        }
                    }
                })
            }
            .sheet(item: $selectedGame) { game in
                GameDetailView(game: game)
                    .environmentObject(gameCatalogue)
            }
        }
        .onAppear {
            isFocused = true
        }
    }
    
    func fetchGames() {
        igdbService.searchGame(name: searchText) { result in
            switch result {
            case .success(let games):
                searchResults = games
            case .failure(let error):
                print("Error searching games: \(error)")
            }
        }
    }
}
