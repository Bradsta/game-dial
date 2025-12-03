//
//  GameCard.swift
//  GameDial
//

import SwiftUI
import SDWebImageSwiftUI

struct GameCard: View {
    let game: Game
    
    var body: some View {
        VStack {
            WebImage(url: URL(string: game.getCoverUrlStr()))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            Text(game.name)
                .font(.headline)
        }
    }
}
