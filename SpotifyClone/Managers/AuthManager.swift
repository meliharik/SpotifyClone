//
//  AuthManager.swift
//  SpotifyClone
//
//  Created by melih arik on 12/5/22.
//

import Foundation

class AuthManager {
    static let shared = AuthManager()
    
    struct Constants {
        static let clientID = "cca778b301a74801af9d6c8dbbd31a6c"
        static let clientSecret = "f325a2bd247e4dceb8157b2f84bc50ed"
    }
    
    private init(){}
    
    public var signInURL: URL? {
        let scopes = "user-read-private"
        let redirectURI = "spotify-ios-quick-start://spotify-login-callback"
        let base = "https://accounts.spotify.com/authorize"
        let string = "\(base)?response_type=code&client_id=\(Constants.clientID)&scope=\(scopes)&redirect_uri=\(redirectURI)&show_dialog+TRUE"
        return URL(string: string)
    }
    
    var isSigned: Bool {
        return false
    }
    
    private var accessToken: String? {
        return nil
    }
    
    private var refreshToken: String? {
        return nil
    }
    
    private var tokenExpirationDate: Date? {
        return nil
    }
    
    private var shouldRefreshToken: Bool{
        return false
    }
    
    private func exchangeCodeForToken(code: String, completion: @escaping ((Bool) -> Void)) {
        
    }
    
    public func refreshAccessToken(){
        
    }
    
    private func cacheToken(){
        
    }
}
