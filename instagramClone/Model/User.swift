//
//  User.swift
//  instagramClone
//
//  Created by eunchanKim on 4/18/25.
//

import Foundation


struct User: Codable {
    let id: String
    let email: String
    var username: String
    var name: String
    var bio: String?
    var profileImageUrl: String?
}
