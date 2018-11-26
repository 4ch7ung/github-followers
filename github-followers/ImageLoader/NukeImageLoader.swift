//
//  NukeImageLoader.swift
//  github-followers
//
//  Created by macbook on 24.11.2018.
//  Copyright © 2018 riovcahrenko. All rights reserved.
//

import UIKit
import Nuke

class NukeImageLoader: ImageLoader {
    let name: String = "Nuke"
    
    func loadImage(url: URL, to imageView: UIImageView) {
        Nuke.loadImage(with: url, into: imageView)
    }
    
    func cancelLoadingImage(_ imageView: UIImageView) {
        Nuke.cancelRequest(for: imageView)
    }
}
