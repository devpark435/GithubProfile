//
//  Organization.swift
//  GithubProfile
//
//  Created by 박현렬 on 4/10/24.
//

struct OrganizationModel: Codable {
    let login: String
    let id: Int
    let nodeID: String
    let url: String
    let reposURL: String
    let eventsURL: String
    let hooksURL: String
    let issuesURL: String
    let membersURL: String
    let publicMembersURL: String
    let avatarURL: String
    let description: String

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case url
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case hooksURL = "hooks_url"
        case issuesURL = "issues_url"
        case membersURL = "members_url"
        case publicMembersURL = "public_members_url"
        case avatarURL = "avatar_url"
        case description
    }
}
