//
//  ReadmeResponse.swift
//  GithubProfile
//
//  Created by 박현렬 on 4/10/24.
//

struct ReadmeResponse: Decodable {
    let content: String
    let downloadUrl: String
    
    enum CodingKeys: String, CodingKey {
        case content
        case downloadUrl = "download_url"
    }
}
