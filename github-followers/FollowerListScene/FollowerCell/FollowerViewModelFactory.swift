//
//  FollowerViewModelFactory.swift
//  github-followers
//
//  Created by macbook on 25.11.2018.
//  Copyright © 2018 riovcahrenko. All rights reserved.
//

import Foundation

protocol FollowerVMFactoryProtocol {
    func createFollowerViewModel(model: GithubFollowerModel) -> FollowerVM
}

class FollowerViewModelFactory: FollowerVMFactoryProtocol {
    private let githubAPI: GithubAPI
    
    init(githubAPI: GithubAPI) {
        self.githubAPI = githubAPI
    }
    
    func createFollowerViewModel(model: GithubFollowerModel) -> FollowerVM {
        let vm = FollowerViewModel(githubAPI: githubAPI,
                                   login: model.login,
                                   avatarUrlString: model.avatarUrl,
                                   followersUrlString: model.followersUrl,
                                   userUrlString: model.url)
        return vm
    }
}
