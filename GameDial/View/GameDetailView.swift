//
//  GameDetailView.swift
//  GameDial
//

import SwiftUI
import SDWebImageSwiftUI

struct GameDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var gameCatalogue: GameCatalogue
    @State private var status: GameStatus
    
    var game: Game
    
    init(game: Game) {
        self.game = game
        _status = State(initialValue: game.status ?? GameStatus.backlog)
    }

    var body: some View {
        ScrollView {
            VStack {
                Text(game.name)
                    .font(.largeTitle)
                
                WebImage(url: URL(string: game.getCoverUrlStr()))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .frame(width: 250, height: 350)
                
                Picker("Status", selection: $status) {
                    ForEach(GameStatus.allCases, id: \.self) { status in
                        Text(status.rawValue)
                            .tag(status)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                
                if (gameCatalogue.isInCatalogue(game)) {
                    Button(action: {
                        gameCatalogue.removeGame(game)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Remove from Catalogue")
                            .font(.headline)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                } else {
                    Button(action: {
                        gameCatalogue.addGame(game)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Add to Catalogue")
                            .font(.headline)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                
                Text(game.summary ?? "")
                    .font(.body)
                    .padding()
            }
            .padding()
            .onDisappear {
                gameCatalogue.updateGameStatus(game, status: status)
            }
        }
    }
}
