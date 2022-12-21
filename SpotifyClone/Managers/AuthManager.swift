//
//  AuthManager.swift
//  SpotifyClone
//
//  Created by melih arik on 12/5/22.
//

import Foundation

class AuthManager {
    static let shared = AuthManager()
    
    private var refreshingToken = false
    
    struct Constants {
        static let clientID = "cca778b301a74801af9d6c8dbbd31a6c"
        static let clientSecret = "f325a2bd247e4dceb8157b2f84bc50ed"
        static let tokenAPIURL = "https://accounts.spotify.com/api/token"
        static let redirectURI = "https://zen-mestorf-24330c.netlify.app/"
        static let scopes = "user-read-private%20playlist-modify-public%20playlist-read-private%20playlist-modify-private%20user-follow-read%20user-library-modify%20user-library-read%20user-read-email"
    }
    
    private init(){}
    
    public var signInURL: URL? {
        
        let base = "https://accounts.spotify.com/authorize"
        let string = "\(base)?response_type=code&client_id=\(Constants.clientID)&scope=\(Constants.scopes)&redirect_uri=\(Constants.redirectURI)&show_dialog=TRUE"
        return URL(string: string)
    }
    
    var isSigned: Bool {
        return accessToken != nil
    }
    
    private var accessToken: String? {
        return UserDefaults.standard.string(forKey: "access_token")
    }
    
    private var refreshToken: String? {
        return UserDefaults.standard.string(forKey: "refresh_token")
    }
    
    private var tokenExpirationDate: Date? {
        return UserDefaults.standard.object(forKey: "expirationDate") as? Date
    }
    
    private var shouldRefreshToken: Bool{
        guard let expirationDate = tokenExpirationDate else {
            return false
        }
        
        let currentDate = Date()
        let fiveMinutes: TimeInterval = 300
        
        return currentDate.addingTimeInterval(fiveMinutes) >= expirationDate
    }
    
    public func exchangeCodeForToken(code: String, completion: @escaping ((Bool) -> Void)) {
        //get token
        
        guard let url = URL(string: Constants.tokenAPIURL) else {
            return
        }
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            
            URLQueryItem(name: "code", value: code),
            
            URLQueryItem(name: "redirect_uri", value: Constants.redirectURI),
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded ", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = components.query?.data(using: .utf8)
        
        let basicToken = Constants.clientID+":"+Constants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            print("Failure to get base64")
            completion(false)
            return
        }
        
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(false)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                
                print("SUCCESS: \(result)")
                
                self?.cacheToken(result: result)
                
                completion(true)
            } catch {
                print("hata cnmm")
                print(error.localizedDescription)
                completion(false)
            }
        }
        task.resume()
    }
    
    private var onRefreshBlocks = [((String) -> Void)]()
    
    public func withValidToken(completion: @escaping (String) -> Void) {
        guard !refreshingToken else {
            // Append the completion
            onRefreshBlocks.append(completion)
            return
        }
        
        if shouldRefreshToken {
            refreshIfNeeded { [weak self] success in
                if let token = self?.accessToken, success {
                    completion(token)
                }
            }
        } else if let token = accessToken {
            completion(token)
        }
    }
    
    public func refreshIfNeeded(completion: ((Bool) -> Void)?) {
//        print("1")
        guard !refreshingToken else {
            return
        }
//        print("2")
        
        guard shouldRefreshToken else {
            completion?(true)
            return
        }
//        print("3")
        
        guard let refreshToken = self.refreshToken else {
            return
        }
//        print("4")
        
        //refresh the token
        guard let url = URL(string: Constants.tokenAPIURL) else {
            return
        }
//        print("5")
        
        refreshingToken = true
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "refresh_token"),
            
            URLQueryItem(name: "refresh_token", value: refreshToken),
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = components.query?.data(using: .utf8)
        
        let basicToken = Constants.clientID+":"+Constants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            print("Failure to get base64")
            completion?(false)
            return
        }
        
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            
            self?.refreshingToken = false
            
            guard let data = data, error == nil else {
                completion?(false)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                
                print("SUCCESSFULLY REFRESHED: \(result)")
                
                self?.onRefreshBlocks.forEach { $0(result.access_token )}
                self?.onRefreshBlocks.removeAll()
                
                self?.cacheToken(result: result)
                
                completion?(true)
            } catch {
                print("hata cnmm")
                print(error.localizedDescription)
                completion?(false)
            }
        }
        task.resume()
    }
    
    private func cacheToken(result: AuthResponse){
        UserDefaults.standard.setValue(result.access_token, forKey: "access_token")
        
        if let refresh_token = result.refresh_token {
            UserDefaults.standard.setValue(refresh_token, forKey: "refresh_token")
        }
        
//        print("expires "+String(result.expires_in))
        
//        let modifiedDate = Date().addingTimeInterval(TimeInterval(result.expires_in))
//        let date = Date()
//        print("date")
//        print(date)
//        print("modifiedDate")
//        print(modifiedDate)
        
        // cant save expirationDate
        
        UserDefaults.standard.set(Date().addingTimeInterval(TimeInterval(result.expires_in)),
                                        forKey: "expirationDate")
//        print("expiratinDate: ")
//        print(UserDefaults.standard.object(forKey: "expirationDate"))
        
//        let defaults = UserDefaults.standard
//        defaults.set(Date(), forKey: "currentDate")
//
//        if let storedDate = defaults.object(forKey: "currentDate") as? Date {
//            print("Stored Date: ", storedDate)
//        }
//        print("userDefaulkts2: ")
//        print(UserDefaults.standard.string(forKey: "expirationDate"))
//
//        print("access token: ")
//        print(UserDefaults.standard.string(forKey: "access_token"))
    }
}
