//
//  UIScrollView+ContentView.swift
//
//  Created by Chris Nevin on 18/11/2016.
//  Copyright © 2016 CJNevin. All rights reserved.
//

import UIKit

extension UIScrollView {

    // Add contentView to scrollView applying width and height constraints.
    func constrainContentView(_ contentView: UIView) {
        guard let superview = superview else {
            return
        }
        translatesAutoresizingMaskIntoConstraints = false

        if contentView.superview != self {
            contentView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(contentView)
        }

        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor)
        ])

        let views: [String : Any] = ["scrollView": self, "contentView": contentView]
        let noOptions = NSLayoutFormatOptions(rawValue: 0)

        superview.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "H:|[scrollView]|", options: noOptions, metrics: nil, views: views) +
            NSLayoutConstraint.constraints(
                withVisualFormat: "V:|[scrollView]|", options: noOptions, metrics: nil, views: views) +
            NSLayoutConstraint.constraints(
                withVisualFormat: "H:|[contentView]|", options: noOptions, metrics: nil, views: views) +
            NSLayoutConstraint.constraints(
                withVisualFormat: "V:|[contentView]|", options: noOptions, metrics: nil, views: views)
        )
    }
}
