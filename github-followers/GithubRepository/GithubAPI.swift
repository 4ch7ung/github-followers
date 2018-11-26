//
//  GithubAPI.swift
//  github-followers
//
//  Created by macbook on 23.11.2018.
//  Copyright © 2018 riovcahrenko. All rights reserved.
//

import Foundation

protocol GithubAPI {
    func fetchFollowers(followersURL: URL, callback: @escaping Callback<[GithubFollowerModel]>)
    func getUserData(userURL: URL, callback: @escaping Callback<GithubUserInfoModel>)
}
