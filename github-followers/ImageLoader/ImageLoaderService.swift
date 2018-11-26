//
//  ImageLoaderService.swift
//  github-followers
//
//  Created by macbook on 26.11.2018.
//  Copyright © 2018 riovcahrenko. All rights reserved.
//

import Foundation

protocol ImageLoaderServiceProtocol {
    func getImageLoader() -> ImageLoader
    func switchToNextImageLoader()
    
    var imageLoadersCount: Int { get }
    var outputChannel: Channel<ImageLoader>? { get }
}

class ImageLoaderService: ImageLoaderServiceProtocol {
    let imageLoaders: [ImageLoader]
    var currentImageLoaderIndex: Int
    
    var outputChannel: Channel<ImageLoader>?
    
    init(imageLoaders: [ImageLoader]) {
        self.imageLoaders = imageLoaders
        
        guard !imageLoaders.isEmpty else {
            fatalError("Image loaders array cannot be empty")
        }
        
        self.currentImageLoaderIndex = 0
    }
    
    var imageLoadersCount: Int {
        return imageLoaders.count
    }
    
    func getImageLoader() -> ImageLoader {
        return imageLoaders[currentImageLoaderIndex]
    }
    
    func switchToNextImageLoader() {
        guard imageLoaders.count > 1 else {
            return
        }
        
        if currentImageLoaderIndex >= (imageLoaders.count - 1) {
            currentImageLoaderIndex = 0
        } else {
            currentImageLoaderIndex += 1
        }
        
        outputChannel?.send(getImageLoader())
    }
}
