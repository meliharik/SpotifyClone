//
//  UserProfile.swift
//  SpotifyClone
//
//  Created by melih arik on 12/5/22.
//

import Foundation

struct UserProfile: Codable {
    let country: String
    let display_name: String
    let email: String
    let explicit_content: [String: Bool]
    let external_urls: [String: String]
//    let followers: [String: Codable?]
    let id: String
    let product: String
    let images: [APIImage]
}



//{
//    country = TR;
//    "display_name" = melih;
//    email = "meliharik5@gmail.com";
//    "explicit_content" =     {
//        "filter_enabled" = 0;
//        "filter_locked" = 0;
//    };
//    "external_urls" =     {
//        spotify = "https://open.spotify.com/user/315lqzcou52tiuxjogdtyeoazxb4";
//    };
//    followers =     {
//        href = "<null>";
//        total = 0;
//    };
//    href = "https://api.spotify.com/v1/users/315lqzcou52tiuxjogdtyeoazxb4";
//    id = 315lqzcou52tiuxjogdtyeoazxb4;
//    images =     (
//    );
//    product = open;
//    type = user;
//    uri = "spotify:user:315lqzcou52tiuxjogdtyeoazxb4";
//}
    
