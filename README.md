# game-dial

<div align="center">
  <img src="Images/icon.png" width="250" alt="Currently Playing">
</div>

A personal game catalogue iOS app built with SwiftUI that helps you organize and track your gaming library. Search for games, add them to your collection, and track your progress through different gaming statuses.

## Features

### 🎮 Game Management
- **Search Games**: Search for games using the IGDB (Internet Game Database) API
- **Game Catalogue**: Organize your games in a personal collection
- **Status Tracking**: Track games across multiple categories:
  - 🎮 Playing - Currently active games
  - 🔄 Ongoing - Games you return to regularly
  - 📋 Backlog - Games you plan to play
  - ⭐ Wish List - Games you want to buy
  - ❌ Unfinished - Games you've abandoned
  - ✅ Completed - Finished games

### 📱 User Interface
- **Grid Layout**: Beautiful grid-based game display with cover art
- **Game Cards**: Visually appealing cards showing game covers and titles
- **Detail Views**: Comprehensive game information and status management
- **Search Interface**: Intuitive search with real-time results
- **Status Icons**: Visual indicators for each game status category

### 💾 Data Persistence
- **Local Storage**: Games are saved locally using JSON encoding
- **Automatic Sync**: Changes are automatically saved to device storage
- **Status Updates**: Game status changes persist between app launches

## Technical Details

### Architecture
- **SwiftUI**: Modern declarative UI framework
- **MVVM Pattern**: Clean separation with ObservableObject for data management
- **StateObject/EnvironmentObject**: Proper state management across views

### External Dependencies
- **Alamofire**: HTTP networking for API calls
- **SDWebImageSwiftUI**: Efficient image loading and caching for game covers
- **IGDB API**: Internet Game Database for comprehensive game information

### Key Components

#### Models
- `Game`: Core game model with IGDB integration
- `GameStatus`: Enum for tracking game progress states
- `GameCatalogue`: Observable data manager for the game collection

#### Views
- `ContentView`: Main catalogue view with status-organized game grid
- `SearchView`: Game search interface with IGDB integration
- `GameCard`: Reusable game display component
- `GameDetailView`: Detailed game information and status management

#### Services
- `IGDBService`: API service for game data retrieval with OAuth2 authentication

### Data Flow
1. **Search**: Users search for games via IGDB API
2. **Add to Catalogue**: Selected games are added to the local collection
3. **Status Management**: Users can update game status (Playing, Completed, etc.)
4. **Persistence**: All changes are automatically saved to local JSON storage
5. **Organization**: Games are displayed grouped by their current status

## Requirements

- iOS 14.0+
- Xcode 12.0+
- Swift 5.0+

## Installation

1. Clone the repository
```bash
git clone https://github.com/yourusername/game-dial.git
cd game-dial
```

2. Install dependencies (if using CocoaPods or Swift Package Manager)

3. Configure IGDB API credentials:
   - Get your Client ID and Client Secret from [IGDB API](https://api.igdb.com/)
   - Update the empty `clientId` and `clientSecret` strings in `IGDBService.swift`
   - **Important**: Never commit your actual API credentials to version control

4. Build and run the project in Xcode

## API Integration

GameDial uses the IGDB (Internet Game Database) API to fetch comprehensive game information including:
- Game titles and descriptions
- High-quality cover artwork
- Platform availability
- Release information

The app implements OAuth2 authentication for secure API access and includes intelligent caching for optimal performance.

## Future Enhancements

Potential features for future development:
- [ ] Game rating system
- [ ] Play time tracking
- [ ] Social features and game sharing
- [ ] Advanced filtering and sorting options
- [ ] Cloud sync across devices
- [ ] Game recommendations based on your library
- [ ] Screenshots and notes for each game
- [ ] Export/import functionality

## Screenshots

### Main Catalogue View
![Main Catalogue](Images/main-catalogue.png)
*Organize your games by status with beautiful cover art in a grid layout*

### Search Interface  
![Search View](Images/search-view.png)
*Search the IGDB database and discover new games to add to your collection*

### Game Detail & Status Management
![Game Detail](Images/game-detail.png)
*View detailed game information and update your progress status*

*Track your progress across different gaming statuses*

## Contributing

This is a personal project, but suggestions and feedback are welcome! Feel free to open issues or submit pull requests.

## License

This project is available under the MIT License. See the LICENSE file for more info.

## Acknowledgments

- [IGDB](https://www.igdb.com/) for providing comprehensive game data
- [Alamofire](https://github.com/Alamofire/Alamofire) for networking
- [SDWebImageSwiftUI](https://github.com/SDWebImage/SDWebImageSwiftUI) for image handling

---

Built with ❤️ using SwiftUI
