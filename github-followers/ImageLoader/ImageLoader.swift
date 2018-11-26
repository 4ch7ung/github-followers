//
//  ImageLoader.swift
//  github-followers
//
//  Created by macbook on 24.11.2018.
//  Copyright © 2018 riovcahrenko. All rights reserved.
//

import UIKit

protocol ImageLoader: class {
    var name: String { get }
    
    func loadImage(url: URL, to imageView: UIImageView)
    func cancelLoadingImage(_ imageView: UIImageView)
}
