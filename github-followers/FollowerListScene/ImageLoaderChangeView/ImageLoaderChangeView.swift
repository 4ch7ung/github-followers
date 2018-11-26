//
//  ImageLoaderChangeView.swift
//  github-followers
//
//  Created by macbook on 26.11.2018.
//  Copyright © 2018 riovcahrenko. All rights reserved.
//

import UIKit

class ImageLoaderChangeView: UIView {

    @IBOutlet var imageLoaderNameLabel: UILabel!
    @IBOutlet var changeButton: UIButton!
    
    var viewModel: ImageLoaderChangeVM!
    
    func bindToViewModel(_ viewModel: ImageLoaderChangeVM) {
        self.viewModel = viewModel
        self.changeButton.isHidden = !viewModel.canSwitchImageLoaders
        self.imageLoaderNameLabel.bindNow(to: viewModel.imageLoaderName)
    }

    @IBAction func changePressed(_ button: UIButton?) {
        viewModel.changeImageLoader()
    }
}
