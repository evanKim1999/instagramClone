//
//  Post.swift
//  instagramClone
//
//  Created by eunchanKim on 4/16/25.
//

import Foundation

struct Post: Codable, Identifiable { // Encode, decode 가능
    let id: String
    let userId: String
    let caption: String
    var like: Int
    let imageUrl: String
    let date: Date
}
