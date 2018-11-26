//
//  GithubFollowerModel.swift
//  github-followers
//
//  Created by macbook on 23.11.2018.
//  Copyright © 2018 riovcahrenko. All rights reserved.
//

import Foundation

/*
 {
!    "login": "myhduck",
     "id": 1555350,
     "node_id": "MDQ6VXNlcjE1NTUzNTA=",
!    "avatar_url": "https://avatars2.githubusercontent.com/u/1555350?v=4",
     "gravatar_id": "",
!!   "url": "https://api.github.com/users/myhduck",
     "html_url": "https://github.com/myhduck",
!    "followers_url": "https://api.github.com/users/myhduck/followers",
     "following_url": "https://api.github.com/users/myhduck/following{/other_user}",
     "gists_url": "https://api.github.com/users/myhduck/gists{/gist_id}",
     "starred_url": "https://api.github.com/users/myhduck/starred{/owner}{/repo}",
     "subscriptions_url": "https://api.github.com/users/myhduck/subscriptions",
     "organizations_url": "https://api.github.com/users/myhduck/orgs",
     "repos_url": "https://api.github.com/users/myhduck/repos",
     "events_url": "https://api.github.com/users/myhduck/events{/privacy}",
     "received_events_url": "https://api.github.com/users/myhduck/received_events",
     "type": "User",
     "site_admin": false
 }
 */

struct GithubFollowerModel: Codable {
    
    let avatarUrl: String
    let login: String
    let followersUrl: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        
        case avatarUrl = "avatar_url"
        case followersUrl = "followers_url"
        case login
        case url
    }
}
