//
//  ImageLoaderChangeViewAssembly.swift
//  github-followers
//
//  Created by macbook on 26.11.2018.
//  Copyright © 2018 riovcahrenko. All rights reserved.
//

import UIKit

class ImageLoaderChangeViewAssembly: ViewAssembly {
    private let imageLoaderService: ImageLoaderServiceProtocol
    
    init(imageLoaderService: ImageLoaderServiceProtocol) {
        self.imageLoaderService = imageLoaderService
    }
    
    func assembleView() -> UIView {
        let vm = ImageLoaderChangeViewModel(imageLoaderService: imageLoaderService)
        if let channel = imageLoaderService.outputChannel {
            vm.setInputChannel(channel)
        }
        let bundle = Bundle(for: ImageLoaderChangeView.self)
        guard let view = bundle.loadNibNamed("ImageLoaderChangeView", owner: nil, options: nil)?.first,
            let loaderChangeView = view as? ImageLoaderChangeView else {
            fatalError("Could not load ImageLoaderChangeView xib")
        }
        
        loaderChangeView.bindToViewModel(vm)
        return loaderChangeView
    }
}
