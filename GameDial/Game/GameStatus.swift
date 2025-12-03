//
//  GameStatus.swift
//  GameDial
//

import Foundation

enum GameStatus: String, Codable, CaseIterable {
    case playing = "Playing"
    case ongoing = "Ongoing"
    case backlog = "Backlog"
    case wishlist = "Wish List"
    case unfinished = "Unfinished"
    case completed = "Completed"
    
    var iconName: String {
        switch self {
        case .playing:
            return "play.circle"
        case .ongoing:
            return "arrow.triangle.2.circlepath.circle"
        case .backlog:
            return "tray.circle"
        case .wishlist:
            return "star.circle"
        case .unfinished:
            return "xmark.circle"
        case .completed:
            return "checkmark.circle"
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let statusString = try container.decode(String.self)
        
        switch statusString {
        case "In Progress": // handle old value
            self = .playing
        case "Backlogged":
            self = .backlog
        case "Wishlisted":
            self = .wishlist
        case "Not Started":
            self = .backlog
        case "Abandoned":
            self = .unfinished
        default:
            guard let status = GameStatus(rawValue: statusString) else {
                throw DecodingError.dataCorruptedError(
                    in: container,
                    debugDescription: "Invalid game status: \(statusString)"
                )
            }
            self = status
        }
    }
}
