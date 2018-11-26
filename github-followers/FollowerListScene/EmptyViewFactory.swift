//
//  EmptyViewFactory.swift
//  github-followers
//
//  Created by macbook on 26.11.2018.
//  Copyright © 2018 riovcahrenko. All rights reserved.
//

import UIKit

protocol EmptyViewFactoryProtocol {
    func createView(frame: CGRect, message: String) -> UIView
}

class EmptyViewFactory: EmptyViewFactoryProtocol {
    func createView(frame: CGRect, message: String) -> UIView {
        let emptyView = UIView(frame: frame)
        let emptyLabel = UILabel()
        emptyLabel.textColor = .darkGray
        emptyLabel.textAlignment = .center
        emptyLabel.text = message
        emptyLabel.numberOfLines = 0
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyView.addSubview(emptyLabel)
        let leading = emptyLabel.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor)
        let trailing = emptyLabel.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor)
        let centerY = emptyLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor)
        NSLayoutConstraint.activate([
            leading,
            trailing,
            centerY
            ])
        emptyView.layoutIfNeeded()
        return emptyView
    }
}
