//
//  FollowerViewModel.swift
//  github-followers
//
//  Created by macbook on 24.11.2018.
//  Copyright © 2018 riovcahrenko. All rights reserved.
//

import UIKit

protocol FollowerVM {
    var avatarUrlString: String { get }
    var followersUrlString: String { get }
    
    var login: Dynamic<String> { get }
    var fullname: Dynamic<String> { get }
    var company: Dynamic<String> { get }
    var email: Dynamic<String> { get }
    
    func fetchUserInfo()
}

class FollowerViewModel: FollowerVM {
    private let githubAPI: GithubAPI
    private let userUrlString: String
    
    let avatarUrlString: String
    let followersUrlString: String
    
    var login: Dynamic<String>
    var fullname: Dynamic<String>
    var company: Dynamic<String>
    var email: Dynamic<String>
    
    init(githubAPI: GithubAPI,
         login: String,
         avatarUrlString: String,
         followersUrlString: String,
         userUrlString: String) {
        
        self.githubAPI = githubAPI
        self.avatarUrlString = avatarUrlString
        self.followersUrlString = followersUrlString
        self.userUrlString = userUrlString
        
        self.login = Dynamic(login)
        self.fullname = Dynamic("?")
        self.company = Dynamic("?")
        self.email = Dynamic("?")
    }
    
    func fetchUserInfo() {
        guard let userUrl = URL(string: userUrlString) else {
            // TODO: something
            return
        }
        githubAPI.getUserData(userURL: userUrl) { result in
            switch result {
            case .success(let userInfo):
                DispatchQueue.main.async {
                    self.fullname &= userInfo.name ?? "-"
                    self.company &= userInfo.company ?? "-"
                    self.email &= userInfo.email ?? "-"
                }
            case .failure:
                // TODO: something
                break
            }
        }
    }
}
