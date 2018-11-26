//
//  FollowerListRouter.swift
//  github-followers
//
//  Created by macbook on 25.11.2018.
//  Copyright © 2018 riovcahrenko. All rights reserved.
//

import UIKit

class FollowerListRouter {
    private let assembly: FollowerListAssembly
    var navigationController: UINavigationController?
    
    init(followerListViewAssembly: FollowerListAssembly) {
        self.assembly = followerListViewAssembly
    }
    
    func showFollowerList(forUser login: String, followersUrlString: String) {
        let view = assembly.assembleView(login: login, followersUrlString: followersUrlString)
        navigationController?.pushViewController(view, animated: true)
    }
}
