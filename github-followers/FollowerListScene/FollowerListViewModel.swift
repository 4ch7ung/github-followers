//
//  FollowerListViewModel.swift
//  github-followers
//
//  Created by macbook on 24.11.2018.
//  Copyright © 2018 riovcahrenko. All rights reserved.
//

import Foundation

protocol FollowerListVMDelegate: class {
    func didLoadFollowers()
    func didFailToLoadFollowers(_ errorMessage: String)
}

protocol FollowerListVM {
    var login: String { get }
    
    var delegate: FollowerListVMDelegate? { get set }
    var followersDataManager: FollowerListDataManager { get }
    
    func loadFollowers()
}

class FollowerListViewModel: FollowerListVM {
    
    private var githubAPI: GithubAPI
    private var followersUrlString: String
    
    var login: String
    
    var followerFactory: FollowerVMFactoryProtocol
    var followersDataManager: FollowerListDataManager
    
    weak var delegate: FollowerListVMDelegate?
    
    init(githubAPI: GithubAPI,
         followerFactory: FollowerVMFactoryProtocol,
         login: String,
         followersUrlString: String) {
        
        self.githubAPI = githubAPI
        self.followerFactory = followerFactory
        self.login = login
        self.followersUrlString = followersUrlString
        self.followersDataManager = FollowerListDataManager()
    }
    
    func loadFollowers() {
        guard let followersURL = URL(string: followersUrlString) else {
            delegate?.didFailToLoadFollowers("Provided URL is incorrect: \(followersUrlString)")
            return
        }
        githubAPI.fetchFollowers(followersURL: followersURL) { result in
            switch result {
            case .success(let followerList):
                self.followersDataManager.followers = followerList.compactMap {
                    return self.followerFactory.createFollowerViewModel(model: $0)
                }
                DispatchQueue.main.async {
                    self.delegate?.didLoadFollowers()
                }
            case .failure(let error):
                let failureMessage = "Failed to load followers: \(error.localizedDescription). Pull to retry"
                DispatchQueue.main.async {
                    self.delegate?.didFailToLoadFollowers(failureMessage)
                }
            }
        }
    }
}
