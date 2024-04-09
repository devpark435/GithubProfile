//
//  Repo.swift
//  GithubProfile
//
//  Created by 박현렬 on 4/10/24.
//

import Foundation
struct Repository: Codable {
    let id: Int
    let name: String
    let fullName: String
    let owner: Owner
    let description: String?
    let language: String?
    let htmlURL: String
    // 필요한 다른 프로퍼티 추가
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case fullName = "full_name"
        case owner
        case description
        case language
        case htmlURL = "html_url"
    }
}

struct Owner: Codable {
    let login: String
    let avatarURL: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
    }
}
