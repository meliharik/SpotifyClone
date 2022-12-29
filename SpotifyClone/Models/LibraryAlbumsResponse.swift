//
//  LibraryAlbumsResponse.swift
//  SpotifyClone
//
//  Created by melih arik on 12/29/22.
//

import Foundation

struct LibraryAlbumsResponse: Codable {
    let items: [SavedAlbum]
}

struct SavedAlbum: Codable {
    let album: Album
    let added_at: String
}
