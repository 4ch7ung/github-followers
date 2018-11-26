//
//  FollowerListAssembly.swift
//  github-followers
//
//  Created by macbook on 24.11.2018.
//  Copyright © 2018 riovcahrenko. All rights reserved.
//

import UIKit

class FollowerListAssembly {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func assembleView(login: String, followersUrlString: String) -> UIViewController {
        let githubAPI = AlamofireGithubAPI()
        let followerFactory = FollowerViewModelFactory(githubAPI: githubAPI)
        
        let viewModel = FollowerListViewModel(githubAPI: githubAPI,
                                              followerFactory: followerFactory,
                                              login: login,
                                              followersUrlString: followersUrlString)
        let viewController = FollowerListViewController()
        viewController.viewModel = viewModel
        
        let assembly = FollowerListAssembly(navigationController: navigationController)
        let router = FollowerListRouter(followerListViewAssembly: assembly)
        router.navigationController = navigationController
        viewController.router = router
        
        return viewController
    }
}
