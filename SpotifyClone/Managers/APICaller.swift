//
//  APICaller.swift
//  SpotifyClone
//
//  Created by melih arik on 12/5/22.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    private init(){}
    
    public func getCurrentUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void){
        
    }
}
