//
//  IGDBService.swift
//  GameDial
//

import Alamofire
import Foundation

class IGDBService {
    // Replace the clientId/clientSecret with your personal IGDB API client id / secret.
    let clientId = ""
    let clientSecret = ""
    
    var accessToken: String? = nil
    var expiryTime: Date? = nil

    func searchGame(name: String, completion: @escaping (Result<[Game], Error>) -> Void) {
        getAccessToken { accessToken, error in
            if let error = error {
                print("Error retrieving access token: \(error)")
                return
            }
            
            guard let accessToken = accessToken else {
                print("Access token is nil")
                return
            }
            
            let headers: HTTPHeaders = [
                "Client-ID": self.clientId,
                "Authorization": "Bearer " + accessToken,
                "Accept": "application/json"
            ]

            let body = "search \"\(name)\"; fields name,summary,cover.url,platforms.name; limit 10;"
            let url = URL(string: "https://api.igdb.com/v4/games")!
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = HTTPMethod.post.rawValue
            urlRequest.headers = headers
            urlRequest.httpBody = body.data(using: .utf8)

            AF.request(urlRequest)
                .validate()
                .responseDecodable(of: [Game].self) { response in
                    switch response.result {
                    case .success(let games):
                        completion(.success(games))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    }
    
    func getAccessToken(completion: @escaping (String?, Error?) -> Void) {
        // If we have a token and it's not expired, use it.
        if let token = accessToken, let expiryTime = expiryTime, Date() < expiryTime {
            completion(token, nil)
        } else {
            // Otherwise, fetch a new token.
            let parameters: [String: String] = [
                "client_id": self.clientId,
                "client_secret": self.clientSecret,
                "grant_type": "client_credentials"
            ]
            
            AF.request("https://id.twitch.tv/oauth2/token", method: .post, parameters: parameters)
                .validate()
                .responseDecodable(of: AccessTokenResponse.self) { response in
                    switch response.result {
                    case .success(let data):
                        self.accessToken = data.access_token
                        // Subtract a little time from the expiry time to account for any delay between when the server sent the response and now.
                        self.expiryTime = Date().addingTimeInterval(TimeInterval(data.expires_in - 60))
                        completion(data.access_token, nil)
                    case .failure(let error):
                        completion(nil, error)
                    }
                }
        }
    }
}

struct AccessTokenResponse: Decodable {
    let access_token: String
    let expires_in: Int
    let token_type: String
}
