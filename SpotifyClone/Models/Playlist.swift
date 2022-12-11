//
//  Playlist.swift
//  SpotifyClone
//
//  Created by melih arik on 12/5/22.
//

import Foundation

struct Playlist: Codable {
    let description: String
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let name: String
    let owner: User
}
