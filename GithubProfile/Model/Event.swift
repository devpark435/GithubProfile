//
//  Event.swift
//  GithubProfile
//
//  Created by 박현렬 on 4/10/24.
//

import Foundation

struct EventModel: Codable {
    let id: String
    let type: String
    let actor: Actor
    let repo: Repo
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id, type, actor, repo
        case createdAt = "created_at"
    }
}

struct Repo: Codable {
    let id: Int
    let name: String
    let url: String
}

struct Actor: Codable {
    let id: Int
    let login: String
    let displayLogin: String
    let gravatarID: String
    let url: String
    let avatarURL: String
    
    enum CodingKeys: String, CodingKey {
        case id, login
        case displayLogin = "display_login"
        case gravatarID = "gravatar_id"
        case url
        case avatarURL = "avatar_url"
    }
}
