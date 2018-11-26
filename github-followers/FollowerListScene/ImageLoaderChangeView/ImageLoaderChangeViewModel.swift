//
//  ImageLoaderChangeViewModel.swift
//  github-followers
//
//  Created by macbook on 26.11.2018.
//  Copyright © 2018 riovcahrenko. All rights reserved.
//

import Foundation

protocol ImageLoaderChangeVM {
    var imageLoaderName: Dynamic<String> { get }
    var canSwitchImageLoaders: Bool { get }
    
    func changeImageLoader()
}

class ImageLoaderChangeViewModel: ImageLoaderChangeVM {
    private let imageLoaderService: ImageLoaderServiceProtocol
    private var inputChannel: Channel<ImageLoader>?
    
    var imageLoaderName: Dynamic<String>
    var canSwitchImageLoaders: Bool
    
    init(imageLoaderService: ImageLoaderServiceProtocol) {
        self.imageLoaderService = imageLoaderService
        
        let imageLoader = imageLoaderService.getImageLoader()
        self.imageLoaderName = Dynamic(imageLoader.name)
        self.canSwitchImageLoaders = imageLoaderService.imageLoadersCount > 1
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
            self?.imageLoaderName &= imageLoader.name
        })
        self.inputChannel?.addObserver(observer)
    }
    
    func changeImageLoader() {
        imageLoaderService.switchToNextImageLoader()
    }
}
