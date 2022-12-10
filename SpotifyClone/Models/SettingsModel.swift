//
//  SettingsModel.swift
//  SpotifyClone
//
//  Created by melih arik on 12/9/22.
//

import Foundation

struct Section {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let handler: () -> Void
}
