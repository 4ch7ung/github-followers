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
    @IBOutlet var imageLoaderPlaceholder: PlaceholderView!
    var imageLoaderControlView: UIView?
    var emptyViewFactory: EmptyViewFactoryProtocol?
    
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
        
        setupImageLoaderControl()
        
        bindToViewModel()
        refreshController.beginRefreshing()
        viewModel.loadFollowers()
    }
    
    private func bindToViewModel() {
        self.navigationItem.title = "Followers of \(viewModel.login)"
        tableView.delegate = viewModel.followersDataManager
        tableView.dataSource = viewModel.followersDataManager
        tableView.prefetchDataSource = viewModel.followersDataManager
        
        viewModel.followersDataManager.delegate = self
    }
    
    func setupImageLoaderControl() {
        if let insertedView = imageLoaderControlView {
            self.imageLoaderPlaceholder.insertContentView(insertedView)
            insertedView.didMoveToSuperview()
        }
    }
    
    @objc func refresh(_ refreshControl: UIRefreshControl) {
        tableView.backgroundView = nil
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
        tableView.backgroundView = nil
        tableView.reloadData()
    }
    
    func didFailToLoadFollowers(_ errorMessage: String) {
        refreshController.endRefreshing()
        let emptyView = emptyViewFactory?.createView(frame: tableView.bounds, message: errorMessage)
        tableView.backgroundView = emptyView
        tableView.reloadData()
    }
}
