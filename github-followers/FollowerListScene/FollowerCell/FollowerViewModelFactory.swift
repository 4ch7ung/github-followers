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
    private let imageLoaderService: ImageLoaderServiceProtocol
    
    init(githubAPI: GithubAPI,
         imageLoaderService: ImageLoaderServiceProtocol) {
        self.githubAPI = githubAPI
        self.imageLoaderService = imageLoaderService
    }
    
    func createFollowerViewModel(model: GithubFollowerModel) -> FollowerVM {
        let vm = FollowerViewModel(githubAPI: githubAPI,
                                   imageLoader: imageLoaderService.getImageLoader(),
                                   login: model.login,
                                   avatarUrlString: model.avatarUrl,
                                   followersUrlString: model.followersUrl,
                                   userUrlString: model.url)
        if let channel = imageLoaderService.outputChannel {
            vm.setInputChannel(channel)
        }
        return vm
    }
}
