//
//  KingfisherImageLoader.swift
//  github-followers
//
//  Created by macbook on 24.11.2018.
//  Copyright © 2018 riovcahrenko. All rights reserved.
//

import UIKit
import Kingfisher

class KingfisherImageLoader: ImageLoader {
    let name: String = "Kingfisher"
    
    func loadImage(url: URL, to imageView: UIImageView) {
        imageView.kf.setImage(with: url)
    }
    
    func cancelLoadingImage(_ imageView: UIImageView) {
        imageView.kf.cancelDownloadTask()
    }
}
