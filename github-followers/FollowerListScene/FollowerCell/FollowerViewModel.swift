//
//  FollowerViewModel.swift
//  github-followers
//
//  Created by macbook on 24.11.2018.
//  Copyright © 2018 riovcahrenko. All rights reserved.
//

import UIKit

protocol FollowerVMDelegate: class {
    func didUpdateImageLoader(_ imageLoader: ImageLoader)
}

protocol FollowerVM {
    var avatarUrlString: String { get }
    var followersUrlString: String { get }
    
    var login: Dynamic<String> { get }
    var fullname: Dynamic<String> { get }
    var company: Dynamic<String> { get }
    var email: Dynamic<String> { get }
    
    var delegate: FollowerVMDelegate? { get set }
    
    func fetchUserInfo()
}

class FollowerViewModel: FollowerVM {
    private let githubAPI: GithubAPI
    private let userUrlString: String
    private var imageLoader: ImageLoader
    
    let avatarUrlString: String
    let followersUrlString: String
    
    var login: Dynamic<String>
    var fullname: Dynamic<String>
    var company: Dynamic<String>
    var email: Dynamic<String>
    
    weak var delegate: FollowerVMDelegate?
    
    var inputChannel: Channel<ImageLoader>?
    
    init(githubAPI: GithubAPI,
         imageLoader: ImageLoader,
         login: String,
         avatarUrlString: String,
         followersUrlString: String,
         userUrlString: String) {
        
        self.githubAPI = githubAPI
        self.imageLoader = imageLoader
        self.avatarUrlString = avatarUrlString
        self.followersUrlString = followersUrlString
        self.userUrlString = userUrlString
        
        self.login = Dynamic(login)
        self.fullname = Dynamic("?")
        self.company = Dynamic("?")
        self.email = Dynamic("?")
    }
    
    private lazy var objId: String = {
        let id = "\(type(of: self)):\(String(format: "%p", unsafeBitCast(self, to: Int.self)))"
        return id
    }()
    
    deinit {
        self.inputChannel?.removeObserver(withId: self.objId)
        self.inputChannel = nil
    }
    
    func setInputChannel(_ channel: Channel<ImageLoader>) {
        self.inputChannel = channel
        let observer = Observer<ImageLoader>(id: objId, callback: { [weak self] imageLoader in
            self?.updateImageLoader(imageLoader)
        })
        self.inputChannel?.addObserver(observer)
    }
    
    func updateImageLoader(_ imageLoader: ImageLoader) {
        self.imageLoader = imageLoader
        delegate?.didUpdateImageLoader(imageLoader)
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
                    
                    self.delegate?.didUpdateImageLoader(self.imageLoader)
                }
            case .failure:
                // TODO: something
                break
            }
        }
    }
}
