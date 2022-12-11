//
//  Artist.swift
//  SpotifyClone
//
//  Created by melih arik on 12/5/22.
//

import Foundation

struct Artist: Codable {
    let id: String
    let name: String
    let type: String
    let external_urls: [String: String]
}
