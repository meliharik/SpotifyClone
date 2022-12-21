//
//  AllCategoriesResponse.swift
//  SpotifyClone
//
//  Created by melih arik on 12/21/22.
//

import Foundation

struct AllCategoriesResponse: Codable {
    let categories: Categories
}

struct Categories: Codable {
    let items: [Category]
}

struct Category: Codable {
    let id: String
    let name: String
    let icons: [APIImage]
}
