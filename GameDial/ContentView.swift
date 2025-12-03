//
//  ContentView.swift
//  GameDial
//

import SwiftUI

struct ContentView: View {
    @State private var showingSearchView = false
    @State private var selectedGame: Game?
    @EnvironmentObject var gameCatalogue: GameCatalogue
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    let igdbService = IGDBService()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(GameStatus.allCases, id: \.self) { status in
                        let gamesWithStatus = gameCatalogue.games.filter { $0.status == status }
                        if !gamesWithStatus.isEmpty {
                            HStack {
                                Text(status.rawValue)
                                    .font(.title)
                                Image(systemName: status.iconName)
                                    .font(.title)
                            }
                            .padding(.top)
                            
                            LazyVGrid(columns: columns, spacing: 20) {
                                ForEach(gamesWithStatus) { game in
                                    GameCard(game: game).onTapGesture {
                                        selectedGame = game
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Game Catalogue", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                showingSearchView = true
            }) {
                Image(systemName: "magnifyingglass")
            })
            .sheet(isPresented: $showingSearchView) {
                SearchView().environmentObject(gameCatalogue)
            }
            .sheet(item: $selectedGame) { game in
                GameDetailView(game: game)
                    .environmentObject(gameCatalogue)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
