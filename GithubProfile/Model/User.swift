//
//  User.swift
//  GithubProfile
//
//  Created by 박현렬 on 4/9/24.
//

class User: Codable {
    static let shared = User()
    
    var login: String = ""
    var id: Int = 0
    var nodeID: String = ""
    var avatarURL: String = ""
    var gravatarID: String = ""
    var url: String = ""
    var htmlURL: String = ""
    var followersURL: String = ""
    var followingURL: String = ""
    var gistsURL: String = ""
    var starredURL: String = ""
    var subscriptionsURL: String = ""
    var organizationsURL: String = ""
    var reposURL: String = ""
    var eventsURL: String = ""
    var receivedEventsURL: String = ""
    var type: String = ""
    var siteAdmin: Bool = false
    var name: String?
    var company: String?
    var blog: String = ""
    var location: String?
    var email: String?
    var hireable: Bool?
    var bio: String?
    var twitterUsername: String?
    var publicRepos: Int = 0
    var publicGists: Int = 0
    var followers: Int = 0
    var following: Int = 0
    var createdAt: String = ""
    var updatedAt: String = ""
    
    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case siteAdmin = "site_admin"
        case name, company, blog, location, email, hireable, bio
        case twitterUsername = "twitter_username"
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case followers, following
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    func update(with user: User) {
        login = user.login
        id = user.id
        nodeID = user.nodeID
        avatarURL = user.avatarURL
        gravatarID = user.gravatarID
        url = user.url
        htmlURL = user.htmlURL
        followersURL = user.followersURL
        followingURL = user.followingURL
        gistsURL = user.gistsURL
        starredURL = user.starredURL
        subscriptionsURL = user.subscriptionsURL
        organizationsURL = user.organizationsURL
        reposURL = user.reposURL
        eventsURL = user.eventsURL
        receivedEventsURL = user.receivedEventsURL
        type = user.type
        siteAdmin = user.siteAdmin
        name = user.name
        company = user.company
        blog = user.blog
        location = user.location
        email = user.email
        hireable = user.hireable
        bio = user.bio
        twitterUsername = user.twitterUsername
        publicRepos = user.publicRepos
        publicGists = user.publicGists
        followers = user.followers
        following = user.following
        createdAt = user.createdAt
        updatedAt = user.updatedAt
    }
}
