//
//  FollowerListViewController.swift
//  github-followers
//
//  Created by macbook on 23.11.2018.
//  Copyright © 2018 riovcahrenko. All rights reserved.
//

import UIKit

class FollowerListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var refreshController: UIRefreshControl!
    var router: FollowerListRouter?
    
    var viewModel: FollowerListVM! {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellNib = UINib(nibName: "FollowerTableViewCell",
                            bundle: Bundle(for: FollowerTableViewCell.self))
        tableView.register(cellNib, forCellReuseIdentifier: "FollowerCell")
        
        refreshController = UIRefreshControl()
        refreshController.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        tableView.refreshControl = refreshController
        
        bindToViewModel()
        refreshController.beginRefreshing()
        viewModel.loadFollowers()
    }
    
    func bindToViewModel() {
        self.navigationItem.title = "Followers of \(viewModel.login)"
        tableView.delegate = viewModel.followersDataManager
        tableView.dataSource = viewModel.followersDataManager
        tableView.prefetchDataSource = viewModel.followersDataManager
        
        viewModel.followersDataManager.delegate = self
    }
    
    @objc func refresh(_ refreshControl: UIRefreshControl) {
        viewModel.loadFollowers()
    }
}

extension FollowerListViewController: FollowersListManagerDelegate {
    func didSelectUser(_ user: String, followersUrlString: String) {
        router?.showFollowerList(forUser: user,
                                 followersUrlString: followersUrlString)
    }
}

extension FollowerListViewController: FollowerListVMDelegate {
    func didLoadFollowers() {
        refreshController.endRefreshing()
        tableView.reloadData()
    }
    
    func didFailToLoadFollowers(_ errorMessage: String) {
        refreshController.endRefreshing()
        // TODO: Show the message
        NSLog(errorMessage)
        tableView.reloadData()
    }
}