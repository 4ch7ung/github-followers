//
//  AlamofireGithubAPI.swift
//  github-followers
//
//  Created by macbook on 23.11.2018.
//  Copyright © 2018 riovcahrenko. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireGithubAPI: GithubAPI {
    let queue: DispatchQueue
    
    init() {
        self.queue = DispatchQueue(label: "github-api-queue")
    }
    
    func fetchFollowers(followersURL: URL, callback: @escaping Callback<[GithubFollowerModel]>) {
        Alamofire.request(followersURL)
            .validate()
            .responseData(queue: self.queue) { response in
                
                switch response.result {
                case .success(let data):
                    do {
                        let followers = try JSONDecoder().decode([GithubFollowerModel].self, from: data)
                        callback(.success(followers))
                    } catch let error {
                        callback(.failure(GithubAPIError.fetchFailed(error)))
                    }
                case .failure(let error):
                    callback(.failure(GithubAPIError.fetchFailed(error)))
                }
            }
    }
    
    func getUserData(userURL: URL, callback: @escaping Callback<GithubUserInfoModel>) {
        Alamofire.request(userURL)
            .validate()
            .responseData(queue: self.queue) { response in
                
                switch response.result {
                case .success(let data):
                    do {
                        let userInfo = try JSONDecoder().decode(GithubUserInfoModel.self, from: data)
                        callback(.success(userInfo))
                    } catch let error {
                        callback(.failure(GithubAPIError.fetchFailed(error)))
                    }
                case .failure(let error):
                    callback(.failure(GithubAPIError.fetchFailed(error)))
                }
            }
    }
}

enum GithubAPIError: LocalizedError {
    case errorneosResponse
    case fetchFailed(Error)
    
    var errorDescription: String? {
        switch self {
        case .errorneosResponse:
            return "HTTP call resulted in error response data"
        case .fetchFailed(let error):
            return "Fetching failed, please retry.\n\"\(error.localizedDescription)\""
        }
    }
}
