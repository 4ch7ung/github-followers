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
    let imageLoaderService: ImageLoaderServiceProtocol
    
    init(navigationController: UINavigationController,
         imageLoaderService: ImageLoaderServiceProtocol) {
        
        self.navigationController = navigationController
        self.imageLoaderService = imageLoaderService
    }
    
    func assembleView(login: String, followersUrlString: String) -> UIViewController {
        let githubAPI = AlamofireGithubAPI()
        let followerFactory = FollowerViewModelFactory(githubAPI: githubAPI,
                                                       imageLoaderService: imageLoaderService)
        
        let imageLoaderAssembly = ImageLoaderChangeViewAssembly(imageLoaderService: imageLoaderService)
        let imageLoaderView = imageLoaderAssembly.assembleView()
        
        let viewModel = FollowerListViewModel(githubAPI: githubAPI,
                                              followerFactory: followerFactory,
                                              login: login,
                                              followersUrlString: followersUrlString)
        let viewController = FollowerListViewController()
        viewController.viewModel = viewModel
        viewController.imageLoaderControlView = imageLoaderView
        
        let assembly = FollowerListAssembly(navigationController: navigationController,
                                            imageLoaderService: imageLoaderService)
        let router = FollowerListRouter(followerListViewAssembly: assembly)
        router.navigationController = navigationController
        viewController.router = router
        
        return viewController
    }
}
