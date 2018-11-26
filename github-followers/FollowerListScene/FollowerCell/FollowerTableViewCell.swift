//
//  FollowerTableViewCell.swift
//  github-followers
//
//  Created by macbook on 24.11.2018.
//  Copyright © 2018 riovcahrenko. All rights reserved.
//

import UIKit

class FollowerTableViewCell: UITableViewCell {

    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var loginLabel: UILabel!
    @IBOutlet var fullnameLabel: UILabel!
    @IBOutlet var companyLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    
    private var viewModel: FollowerVM?
    
    func configure(viewModel: FollowerVM) {
        self.viewModel = viewModel
        
        loginLabel.bindNow(to: viewModel.login)
        fullnameLabel.bindNow(to: viewModel.fullname)
        companyLabel.bindNow(to: viewModel.company)
        emailLabel.bindNow(to: viewModel.email)
        
        viewModel.fetchUserInfo()
        if let url = URL(string: viewModel.avatarUrlString) {
            NukeImageLoader().loadImage(url: url, to: avatarImageView)
        }
    }
}
