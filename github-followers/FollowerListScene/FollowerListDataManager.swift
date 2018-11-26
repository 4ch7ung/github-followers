//
//  FollowerListDataManager.swift
//  github-followers
//
//  Created by macbook on 24.11.2018.
//  Copyright © 2018 riovcahrenko. All rights reserved.
//

import UIKit

protocol FollowersListManagerDelegate: class {
    func didSelectUser(_ user: String, followersUrlString: String)
}

class FollowerListDataManager: NSObject,
                                UITableViewDelegate,
                                UITableViewDataSource,
                                UITableViewDataSourcePrefetching {
    
    var followers: [FollowerVM] = []
    weak var delegate: FollowersListManagerDelegate?
    
    // MARK: UITableViewDataSourcePrefetching
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
    }
    
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowerCell", for: indexPath)
        guard let followerCell = cell as? FollowerTableViewCell else {
            fatalError("Could not cast cell to \(FollowerTableViewCell.self)")
        }
        
        let followerVM = followers[indexPath.row]
        followerCell.configure(viewModel: followerVM)
        
        return followerCell
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112.5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let followerVM = followers[indexPath.row]
        delegate?.didSelectUser(followerVM.login.value, followersUrlString: followerVM.followersUrlString)
    }
}
