//
//  Result.swift
//  github-followers
//
//  Created by macbook on 23.11.2018.
//  Copyright © 2018 riovcahrenko. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}

typealias Callback<T> = (Result<T>) -> Void
