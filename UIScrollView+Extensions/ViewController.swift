//
//  ViewController.swift
//  UIScrollView+Extensions
//
//  Created by Chris Nevin on 18/11/2016.
//  Copyright © 2016 CJNevin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    let scrollView = UIScrollView()
    let contentView = UIView()

    var lastPage: Int = 0

    override func loadView() {
        super.loadView()

        view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        var constraints = [NSLayoutConstraint]()
        var coloredViews = [UIView]()
        let colors: [UIColor] = [.red, .blue, .yellow, .green, .purple]
        for (index, color) in colors.enumerated() {
            let coloredView = UIView()
            coloredView.backgroundColor = color
            coloredView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(coloredView)
            coloredViews.append(coloredView)
            constraints += [
                coloredView.leadingAnchor.constraint(equalTo: index == 0 ? contentView.leadingAnchor : coloredViews[index - 1].trailingAnchor),
                coloredView.widthAnchor.constraint(equalTo: view.widthAnchor),
                coloredView.heightAnchor.constraint(equalTo: view.heightAnchor)
            ]
        }

        constraints.append(contentView.trailingAnchor.constraint(equalTo: coloredViews.last!.trailingAnchor))

        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.constrainContentView(contentView)

        NSLayoutConstraint.activate(constraints + [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("Visible pages:", scrollView.visiblePages)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        lastPage = scrollView.currentPage
        print("Current page:", lastPage)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // Handle rotation in a rather primitive way
        scrollView.currentPage = lastPage
    }
}

