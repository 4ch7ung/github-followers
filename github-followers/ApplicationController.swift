//
//  ApplicationController.swift
//  github-followers
//
//  Created by macbook on 23.11.2018.
//  Copyright © 2018 riovcahrenko. All rights reserved.
//

import UIKit

protocol AppController {
    func start()
}

class ApplicationController: AppController {
    private var window: UIWindow
    
    private let startLogin: String = "octocat"
    private let followersUrlString: String = "https://api.github.com/users/octocat/followers"
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navController = UINavigationController()
        let imageLoaderService = ImageLoaderService(imageLoaders: [
            NukeImageLoader(),
            KingfisherImageLoader()
            ])
        imageLoaderService.outputChannel = Channel<ImageLoader>()
        let assembly = FollowerListAssembly(navigationController: navController,
                                            imageLoaderService: imageLoaderService)
        let mainVc = assembly.assembleView(login: startLogin,
                                           followersUrlString: followersUrlString)
        
        navController.setViewControllers([mainVc], animated: false)
        window.rootViewController = navController
        
        window.makeKeyAndVisible()
    }
}
