//
//  DynamicExtensions.swift
//  github-followers
//
//  Created by macbook on 24.11.2018.
//  Copyright © 2018 riovcahrenko. All rights reserved.
//

import UIKit

extension UIImageView {
    func bind(to dynamic: Dynamic<UIImage>) {
        dynamic.bind { self.image = $0 }
    }
    
    func bindNow(to dynamic: Dynamic<UIImage>) {
        dynamic.bindAndFire { self.image = $0 }
    }
}

extension UILabel {
    func bind(to dynamic: Dynamic<String>) {
        dynamic.bind { self.text = $0 }
    }
    
    func bindNow(to dynamic: Dynamic<String>) {
        dynamic.bindAndFire { self.text = $0 }
    }
}
