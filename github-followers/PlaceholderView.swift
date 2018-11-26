//
//  PlaceholderView.swift
//  github-followers
//
//  Created by macbook on 26.11.2018.
//  Copyright © 2018 riovcahrenko. All rights reserved.
//

import UIKit

class PlaceholderView: UIView {
    func insertContentView(_ subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
    
        let left = subview.leftAnchor.constraint(equalTo: leftAnchor)
        let right = subview.rightAnchor.constraint(equalTo: rightAnchor)
        let top = subview.topAnchor.constraint(equalTo: topAnchor)
        let bottom = subview.bottomAnchor.constraint(equalTo: bottomAnchor)
        NSLayoutConstraint.activate([left, right, top, bottom])
    }
}
