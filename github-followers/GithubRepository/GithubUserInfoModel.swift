//
//  GithubUserInfoModel.swift
//  github-followers
//
//  Created by macbook on 23.11.2018.
//  Copyright © 2018 riovcahrenko. All rights reserved.
//

import Foundation

/*
 {
    "login": "myhduck",
    "id": 1555350,
    "node_id": "MDQ6VXNlcjE1NTUzNTA=",
    "avatar_url": "https://avatars2.githubusercontent.com/u/1555350?v=4",
    "gravatar_id": "",
    "url": "https://api.github.com/users/myhduck",
    "html_url": "https://github.com/myhduck",
    "followers_url": "https://api.github.com/users/myhduck/followers",
    "following_url": "https://api.github.com/users/myhduck/following{/other_user}",
    "gists_url": "https://api.github.com/users/myhduck/gists{/gist_id}",
    "starred_url": "https://api.github.com/users/myhduck/starred{/owner}{/repo}",
    "subscriptions_url": "https://api.github.com/users/myhduck/subscriptions",
    "organizations_url": "https://api.github.com/users/myhduck/orgs",
    "repos_url": "https://api.github.com/users/myhduck/repos",
    "events_url": "https://api.github.com/users/myhduck/events{/privacy}",
    "received_events_url": "https://api.github.com/users/myhduck/received_events",
    "type": "User",
    "site_admin": false,
!!  "name": "YOHAN MOON",
!!  "company": "home",
    "blog": "",
    "location": "korea",
!!  "email": null,
    "hireable": null,
    "bio": null,
    "public_repos": 1,
    "public_gists": 0,
    "followers": 2,
    "following": 2,
    "created_at": "2012-03-20T05:15:06Z",
    "updated_at": "2018-09-10T01:55:51Z"
 }
 */

struct GithubUserInfoModel: Codable {
    
    let company: String?
    let name: String?
    let email: String?
    
    enum CodingKeys: String, CodingKey {
        case company
        case name
        case email
    }
}
