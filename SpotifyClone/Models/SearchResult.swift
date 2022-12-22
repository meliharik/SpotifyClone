//
//  SearchResult.swift
//  SpotifyClone
//
//  Created by melih arik on 12/22/22.
//

import Foundation

enum SearchResult {
    case artist(model: Artist)
    case album(model: Album)
    case track(model: AudioTrack)
    case playlist(model: Playlist)
}
